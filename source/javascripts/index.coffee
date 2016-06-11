$ ->
  if $('#index_page').length
    page = 1
    window.block = false
    scrollPos = 0
    oldScrollPos = 0

    downloadPics = (pic, page = 1, per_page = PER_PAGE) ->
      url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=' + API_KEY + '&text=' + pic + '&safe_search=1&page=' + page + '&per_page=' + per_page
      window.block = true
      $('#preloader').show()
      $.ajax({
        dataType: "json"
        url: url + '&format=json&jsoncallback=?'
        success: (data) ->
          if !data["photos"]?
            notify(JSON.stringify(["Problem with data", data]))
          else
            $('#preloader').hide()
            $.each data.photos.photo, (i, item) ->
              # console.log(JSON.stringify(item))
              src = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg'
              # bigImageSrc = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_c.jpg'
              # bigImageSrc = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_h.jpg'
              flickrUrl = 'https://www.flickr.com/photos/' + item.owner + '/' + item.id
              $('#images').append(
                $('<a>').attr('href', flickrUrl).attr('target', '_blank').append(
                  $('<img/>').attr('src', src).attr('class', 'flickr_image')
                )
              )
            window.block = false

            # If there is no scrollbar.
            if $("body").height() <= $(window).height()
              addPics()
        error: (jqXHR, textStatus, errorThrown) ->
          notify(JSON.stringify(['AJAX Error', jqXHR, textStatus, errorThrown]))
      })

    addPics = ->
      downloadPics($('#searchInput').val(), page)
      page++

    doStuff = ->
      $('#images').html('')
      page = 0
      addPics()

    handleEvents = ->
      $('#searchInput').keypress (e)->
        if e.which == 13
          doStuff()

      $('#goButton').click ->
        doStuff()

      $('#hint_links  a').click ->
        $('#searchInput').val(($(this).text().trim()))
        doStuff()

      $(window).scroll ->
        scrollPos = $(window).scrollTop()
        if scrollPos > oldScrollPos
          if ($(document).height() - $(window).height() - $(window).scrollTop()) < INFINITE_SCROLL_OFFSET
            if !window.block
              addPics()
        oldScrollPos = scrollPos

    handleEvents()
    addPics()
