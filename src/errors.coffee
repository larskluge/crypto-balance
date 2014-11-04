class ReqError extends Error
  constructor: (resp) ->
    @name = "ReqError"
    if resp.body.data.address.search /valid address.*required/i >= 0
      @message = "Invalid address"
    else
      @message = "Some API error occured"
    @resp = resp


class InvalidResponseError extends Error
  constructor: (opts) ->
    @name = "InvalidResponseError"
    @message = opts.message or "Server response is invalid"
    @response = opts.response
    @service = opts.service


module.exports =
  "ReqError": ReqError
  "InvalidResponseError": InvalidResponseError

