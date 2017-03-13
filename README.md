# IBREST

## REST API

Use real or demo username/password: edemo/demouser

```
export IB_IbLoginId=username
export IB_IbPassword=password
docker-compose build
docker-compose up -d ibgw

# accept IB auth request on phone
docker-compose up -d ibrest

# hit the market data endpoint
curl http://192.168.99.100:443/market/data/T

```

### Endpoint Groups
The documentation for each of these layers contains these sections, after which IBREST will create endpoints groups when applicable.  An endpoint may provide either a synchronous reponse or an atom feed.

IB Documentation | REST endpoint | Sync or Feed
---------------- | ------------- | --------------------
Connection and Server | NA: Handled by Flask configuration
Market Data | /market/data | Feed
Orders| /order | Sync
Account and Portfolio | /account | Sync
Contract Details | /contract | Sync [TBD]
Executions | /executions | Sync 
Market Depth | /market/depth | Feed [TBD]
News Bulletins | /news | Feed [TBD]
Financial Advisors | /financial | Feed [TBD]
Historical Data | /historical | Sync [TBD]
Market Scanners | /market/scanners | Feed [TBD]
Real Time Bars| /bars | Feed [TBD]
Fundamental Data | /fundamental | Feed [TBD]
Display Groups| /displaygroups | Feed [TBD]

 
### Synchronous Response Endpoint Details
These endpoints return a since single response.   
 
#### GET /order
A GET request retrieves a details for all open orders via `reqAllOpenOrders`.

#### POST /order
A POST request will generate a `placeOrder()` EClient call, then wait for the order to be filled .

#### DELETE /order
A DELETE request will call `cancelOrder()`.

#### GET /account/updates
A GET request to `/account/updates` will use `reqAccountUpdates()` to return messages received from `updateAccountValue/AccountTime()` and `updatePortfolio` EWrapper messages, as triggered by `accountDownloadEnd()`.

#### GET /account/summary
A GET request to `/account/summary` will use `reqAccountSummary()` to return messages received from `updateSummary()` EWrapper message as triggered by `accountSummaryEnd()`.

#### GET /account/positions
A GET request to `/account/positions` will use `reqPostions()` to return messages received from `position()` EWrapper message as triggered by `positionEnd()`.

### Atom Feed Endpoint Details
These endpoints are used for atom feeds.  They must be subscribed to or unsubscribed from.  They are not yet implemented
