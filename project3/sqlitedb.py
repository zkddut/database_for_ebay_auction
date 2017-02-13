import web

db = web.database(dbn='sqlite',
        db='Items.db' 
    )

######################BEGIN HELPER METHODS######################

# Enforce foreign key constraints
# WARNING: DO NOT REMOVE THIS!
def enforceForeignKey():
    db.query('PRAGMA foreign_keys = ON')

# initiates a transaction on the database
def transaction():
    return db.transaction()
# Sample usage (in auctionbase.py):
#
# t = sqlitedb.transaction()
# try:
#     sqlitedb.query('[FIRST QUERY STATEMENT]')
#     sqlitedb.query('[SECOND QUERY STATEMENT]')
# except Exception as e:
#     t.rollback()
#     print str(e)
# else:
#     t.commit()
#
# check out http://webpy.org/cookbook/transactions for examples

# returns the current time from your database
def getTime():
    # TODO: update the query string to match
    # the correct column and table name in your database
    query_string = 'select CurrentTime from CurrentTime'
    results = query(query_string)
    # alternatively: return results[0]['currenttime']
    return results[0].CurrentTime # TODO: update this as well to match the
                                  # column name

# returns a single item specified by the Item's ID in the database
# Note: if the `result' list is empty (i.e. there are no items for a
# a given ID), this will throw an Exception!
def getItemById(item_id):
    # TODO: rewrite this method to catch the Exception in case `result' is empty
    query_string = 'select * from Items where item_ID = $itemID'
    result = query(query_string, {'itemID': item_id})
    return result[0]

# wrapper method around web.py's db.query method
# check out http://webpy.org/cookbook/query for more info
def query(query_string, vars = {}):
    return list(db.query(query_string, vars))

#####################END HELPER METHODS#####################

#TODO: additional methods to interact with your database,
# e.g. to update the current time
def setTime(time):
    #db.delete('CurrentTime', where="CurrentTime='2001-12-20 00:00:01'")
    #db.delete('CurrentTime',  where=None)
    #sequence_id = db.insert('CurrentTime', CurrentTime=time)
    sequence_id = db.update('CurrentTime', where='CurrentTime != 0', CurrentTime=time)

def addBid(itemID, userID, price):
    current_time = getTime()
    sequence_id = db.insert('Bids', Time=current_time, ItemID=int(itemID), Amount=float(price), UserID=userID)

def getItem(itemID, category, itemDes, minPrice, maxPrice, status):
    where_string = ''
    query_string = ''
    and_flag = 0
    if (itemID != ''):
	query_string = 'SELECT * FROM Items WHERE ItemID = %s' % (itemID)
    else:
	if (category != ''):
            where_string = '(ItemID IN (SELECT ItemID FROM Category WHERE Category = \'%s\')) ' % (category)
	    and_flag = 1
	if (itemDes != ''):
	    if (and_flag == 1):
		where_string = where_string + ' AND '
	    and_flag = 1
	    where_string = where_string + 'Description LIKE \'%%%s%%\'' % (itemDes)
	if (minPrice != ''):
	    if (and_flag == 1):
		where_string = where_string + ' AND '
	    and_flag = 1
	    where_string = where_string + 'Currently >= %s' % (minPrice)
	if (maxPrice != ''):
	    if (and_flag == 1):
		where_string = where_string + ' AND '
	    and_flag = 1
	    where_string = where_string + 'Currently <= %s' % (maxPrice)
	if (status != 'all'):
	    if (and_flag == 1):
		where_string = where_string + ' AND '
	    and_flag = 1
	    if (status == 'open'):
	        where_string = where_string + ' Started <= \'%s\' AND Ends >= \'%s\' And Buy_Price > Currently' % (getTime(), getTime())
	    elif (status == 'close'):
	        where_string = where_string + ' (Ends < \'%s\' OR Buy_Price <= Currently)' % (getTime())
	    elif (status == 'notStarted'):
	        where_string = where_string + ' Started > \'%s\' ' % (getTime())
	if (and_flag == 1):
	    query_string = 'SELECT * FROM Items WHERE %s' % (where_string)	    
	else:
	    query_string = 'SELECT * FROM Items'

    #print query_string
    results = query(query_string)

    return results

def itemDetails(itemID):
    output = []
    status = web.utils.Storage()
    query_string = 'select * from Items WHERE ItemID = %s AND Started <= \'%s\' AND Ends >= \'%s\' And Buy_Price > Currently' % (itemID, getTime(), getTime())
    Open = query(query_string)
    query_string = 'select * from Items WHERE ItemID = %s AND (Ends < \'%s\' OR Buy_Price <= Currently) ' % (itemID, getTime())
    Close = query(query_string)
    query_string = 'select * from Items WHERE ItemID = %s AND Started > \'%s\' ' % (itemID, getTime())
    NotStarted = query(query_string)
    
    err_flag = 0
    close_flg = 0
    if Open:
	setattr(status, 'Item_Status', 'Open')
	#print "Open"
	err_flag = 1
    if Close:
	setattr(status, 'Item_Status', 'Closed')
	#print "Closed"
	close_flg = 1
	if (err_flag == 1):
	    exit(0)
	else:
	    err_flag = 1
    if NotStarted:
	setattr(status, 'Item_Status', 'NotStarted')
	print "NotStarted"
	if (err_flag == 1):
	   exit(0) 
	err_flag = 1

    #if(err_flag == 0):
#	exit(0)
    
    output.append(status)
    #print output
    query_string = 'select UserID AS Bidder_name, Time AS Time_of_Bid, Amount AS Price_of_Bid from Bids WHERE ItemID = %s ' % (itemID)
    Bids = query(query_string)

    for results in Bids:
	output.append(results)

    if (close_flg == 1):
	query_string = 'select UserID as Win_Bidder, Max(Amount) AS Win_Price from Bids WHERE ItemID = %s ' % (itemID)
	Bids_winner = query(query_string)
	if Bids_winner:
	    output.append(Bids_winner[0])

    query_string = 'select * from Items WHERE ItemID = %s ' % (itemID)
    item_info = query(query_string)
    output.append(item_info[0])

    print output
    return output

