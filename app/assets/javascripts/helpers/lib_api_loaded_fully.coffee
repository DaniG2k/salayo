# @loadExternalJs = (exjs, loadedAlready, callback) ->
#   if loadedAlready()
#     callback() if callback
#   else
#     $.getScript exjs, ->
#       callback() if callback
