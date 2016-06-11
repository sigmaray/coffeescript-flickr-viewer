# Code is crap
# TODO: Refactor

# Settings
API_KEY = '4cc2a6e2419deebfe86eca026cfda157'
PER_PAGE = 20
PER_PAGE = 10

$ ->
  if $('#carousel_page').length
    page = 1
    window.block = false
    scrollPos = 0
    oldScrollPos = 0
    imgs = []

    downloadPics = (pic, page = 1, per_page = PER_PAGE) ->
      url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=' + API_KEY + '&text=' + pic + '&safe_search=1&page=' + page + '&per_page=' + per_page
      window.block = true
      $('#preloader').show()
      $.getJSON url + '&format=json&jsoncallback=?', (data) ->
        $('#preloader').hide()
        $.each data.photos.photo, (i, item) ->
          # console.log(JSON.stringify(item))
          src = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg'
          bigImageSrc = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_c.jpg'
          imgs.push({src: src, bigImageSrc: bigImageSrc})
          # $('#images').append(
          #   $('<a>').attr('href', bigImageSrc).attr('target', '_blank').append(
          #     $('<img/>').attr('src', src).attr('class', 'flickr_image')
          #   )
          # )
        window.block = false
        # alert(JSON.stringify(imgs))
        initCarousel()

    addPics = ->
      downloadPics($('#searchInput').val(), page)
      page++

    btnNum = 0
    handleEvents = ->
      console.log('L89')
      $('form').submit ->
        console.log('L90')
        btnNum++
        # $('#images').html('')
        imgs = []
        page = 0
        addPics()

      # $(window).scroll ->
      #   scrollPos = $(window).scrollTop()
      #   if scrollPos > oldScrollPos
      #     if ($(document).height() - $(window).height() - $(window).scrollTop()) < 300
      #       if !window.block
      #         addPics()
      #   oldScrollPos = scrollPos

    initCarousel = ->
      i = 0
      # imgLength = imgs.le
      oldBtnNum = btnNum
      console.log('L107')
      tttext = $('#searchInput')
      show_popup = ->
        # if btnNum == oldBtnNum # check if button was not clicked one more time
        # if true
        console.log([btnNum, oldBtnNum])
        if btnNum == oldBtnNum # check if button was not clicked one more time
          if !window.block
            console.log('L111')
            # alert('L111')
            $('#img_container').html('');
            # alert(imgs[i].src);
            $('#img_container').append($('<img>').attr('src', imgs[i].bigImageSrc));
            i++;
            if i < imgs.length
              window.setTimeout(show_popup, 3000);
            else
              page++
              imgs = []
              downloadPics(tttext, page)
      show_popup()


    console.log("L132")
    handleEvents()
    console.log("L133")
    addPics()

console.log('L137')