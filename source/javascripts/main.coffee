# Code is crap
# TODO: Refactor

# Settings
API_KEY = '4cc2a6e2419deebfe86eca026cfda157'
PER_PAGE = 20

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
      $.getJSON url + '&format=json&jsoncallback=?', (data) ->
        $('#preloader').hide()
        $.each data.photos.photo, (i, item) ->
          console.log(JSON.stringify(item))
          src = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg'
          bigImageSrc = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_c.jpg'
          $('#images').append(
            $('<a>').attr('href', bigImageSrc).attr('target', '_blank').append(
              $('<img/>').attr('src', src).attr('class', 'flickr_image')
            )
          )
        window.block = false

    addPics = ->
      downloadPics($('#searchInput').val(), page)
      page++

    handleEvents = ->
      $('#goButton').click ->
        $('#images').html('')
        page = 0
        addPics()

      $(window).scroll ->
        scrollPos = $(window).scrollTop()
        if scrollPos > oldScrollPos
          if ($(document).height() - $(window).height() - $(window).scrollTop()) < 300
            if !window.block
              addPics()
        oldScrollPos = scrollPos

    handleEvents()
    addPics()
