# Code is crap
# TODO: Refactor

$ ->
  if $('#carousel_page').length
    page = 1
    scrollPos = 0
    oldScrollPos = 0
    imgs = []

    downloadPics = (pic, page = 1, per_page = PER_PAGE) ->
      url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=' + API_KEY + '&text=' + pic + '&safe_search=1&page=' + page + '&per_page=' + per_page
      $('#preloader').show()
      $.getJSON url + '&format=json&jsoncallback=?', (data) ->
        $('#preloader').hide()
        imgs = []
        $.each data.photos.photo, (i, item) ->
          src = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg'
          bigImageSrc = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_c.jpg'
          imgs.push({src: src, bigImageSrc: bigImageSrc})
        initCarousel()

    addPics = ->
      downloadPics($('#searchInput').val(), page, window.CAROUSEL_PER_PAGE)
      page++

    doStuff = (e) ->
      console.log('L89')
      if window.tmout?
          console.log(["l41", 'clearing timeout'])
          window.clearTimeout(tmout)

      console.log('L90')
      imgs = []
      page = 0
      addPics()

    handleEvents = ->


      $('#goButton').click ->
        doStuff()

      $('#searchInput').keypress (e)->
        if e.which == 13
          doStuff()

    initCarousel = ->
      i = 0
      console.log('L107')
      tttext = $('#searchInput')
      showImageAndStartTimer = ->
        $('#img_container').html('');
        $('#img_container').append($('<img>').attr('src', imgs[i].bigImageSrc));
        i++;
        if i < imgs.length
          window.tmout = window.setTimeout(showImageAndStartTimer, window.CAROUSEL_TIMEOUT_MILLISECONDS);
        else
          page++
          imgs = []
          downloadPics(tttext, page)
      showImageAndStartTimer()


    console.log("L132")
    handleEvents()
    console.log("L133")
    addPics()

console.log('L137')