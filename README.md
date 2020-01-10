Each web service call will include a header with the following items:
1. X-UserID The caller's "User ID" to determine rights to private data
2. X-Stamp Timestamp when the caller made the request. This must be UTC Time (i.e. Greenwich Mean Time), so you
must convert from your local time zone. Format is (mm/dd/yyyy hh:mi:ss AM)
3. X-Signature Signature is made up of the following pieces of information (concatenated together as a single
string value):
    * User ID
    * Timestamp
    * URI
    * Request Method

Signature is then encrypted using the HMAC-SHA256 encryption algorithm and placed in the header element.
