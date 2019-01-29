# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# --------------------------------------
# 関数
# --------------------------------------
# 検索クエリをXMLHttpRequestオブジェクトにする
create_request = (query_url, query_word) ->
  $.ajax(
    url:          query_url
    type:        "GET"
    data:        "query=#{query_word}"
    processData:  false
    contentType:  false
    dataType:    "json"
  )

# jsonデータをul要素へ追加する
append_list = (ul_element, json) ->
  ul_element.find("li").remove()
  $(json).each (i, user) -> ul_element.append "<li>#{user.name}</li>"
  return

# インクリメンタル検索
incremental_search = (query_url, query_word, ul_element) ->
  query = create_request(query_url, query_word)
  query.done (json) -> append_list(ul_element, json)
  return

# --------------------------------------
# メイン
# --------------------------------------
$(document).on "keyup", "#form", (event) -> incremental_search("/users/search", $(this).val(), $("#result"))

# 以下オリジナル
#$(document).on 'turbolinks:load', ->
#  $(document).on 'keyup', '#form', (e) ->
#    e.preventDefault()
#    input = $.trim($(this).val())
#    $.ajax(
#      url: '/users/search'
#      type: 'GET'
#      data: 'keyword=' + input
#      processData: false
#      contentType: false
#      dataType: 'json').done (data) ->
#      #データを受け取ることに成功したら、dataを引数に取って以下のことする(dataには@usersが入っている状態ですね)
#      $('#result').find('li').remove()
#      #idがresultの子要素のliを削除する
#      $(data).each (i, user) ->
#        #dataをuserという変数に代入して、以下のことを繰り返し行う(単純なeach文ですね)
#        $('#result').append '<li>' + user.name + '</li>'
#        #resultというidの要素に対して、<li>ユーザーの名前</li>を追加する。
#        return
#      return
#    return
#  return
