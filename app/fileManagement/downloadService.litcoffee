downloadService
===============
This service allows for content to be downloaded without need of a server.

    angular.module 'Villustrator.fileManagement'
    .service 'downloadService', class
      constructor: (@$timeout) ->

`download`
----------
Triggers a file download based on the parameters given.

**Params:**

* `fileName : String`  Name to give downloaded file.
* `content : String` Content of file to be downloaded.
* `opts : Object` Object with additional configuration properties.
  * `opts.mimeType : String`  Mime type of file. Defaults to `text/plain`.
  * `opts.charset : String`: Charset of content. Defaults to `utf-8`.

**Returns:**

`Promise` that is resolved once download begins and rejected if fileName and
content are not set.

      download: (fileName, content, opts = {}) -> @$timeout ->

        unless fileName and content
          throw new Error 'fileName and content are required'

        content = encodeURIComponent(content)
        mimeType = opts.mimeType || 'text/plain'
        charset = opts.charset || 'utf-8'

The implementation here is to construct a link element that has a data URL of
the file contents and trigger a click event on it.

        downloadLink = document.createElement 'a'
        downloadLink.setAttribute 'href', "data:#{mimeType};charset=#{charset},#{content}"
        downloadLink.setAttribute 'download', fileName
        downloadLink.click()
