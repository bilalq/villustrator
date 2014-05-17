downloadManager
===============
This service allows for content to be downloaded without need of a server.

    'use strict'
    angular.module('Villustrator')
    .factory 'downloadManager', ($timeout) ->

`download` function

Triggers a file download based on the parameters given.

Params:

* `fileName`: Name to give downloaded file.
* `content`: Content of file to be downloaded.
* `mimeType`: (optional) Mime type of file. Defaults to `text/plain`.
* `charset`: (optional) Charset of content. Defaults to `utf-8`.

Returns:

A `Promise` that is resolved once download begins and rejected if fileName and
content are not set.

      download: (fileName, content, mimeType, charset) -> $timeout ->

        unless fileName and content
          throw new Error 'fileName and content are required'

        mimeType ||= 'text/plain'
        charset ||= 'utf-8'
        content = encodeURIComponent(content)
        href = "data:#{mimeType};charset=#{charset},#{content}"

        downloadLink = document.createElement 'a'
        downloadLink.setAttribute 'href', href
        downloadLink.setAttribute 'download', fileName
        downloadLink.click()
