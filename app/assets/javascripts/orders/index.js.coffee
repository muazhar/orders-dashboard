$(document).ready ->
  $('#stateSelect').on 'change', ->
    getOrders()

  getOrders()
  setInterval (->
    getOrders()
  ), 15000

getOrders =  ->
  $.ajax buildGetUrl(),
    type: 'GET'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      alert "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      fillTable(data)

fillTable = (data) ->
  $('#orders').html $.map(data, (order, index) ->
    "<tr id=#{data[index].id}>
       <td class='order-index'>#{index + 1}</td>
       <td class='order-created'>#{data[index].created_at}</td>
       <td class='order-address'>#{data[index].address}</td>
       <td class='order-price'>#{data[index].price}</td>
       <td data-state=#{data[index].state} class='order-state'>#{data[index].state}</td>
       <td>
         <button data-id=#{data[index].id} class='btn btn-primary'>Change State</button>
       </td>
     </tr>"
  )

  $('.btn').click ->
    id = $(this).data('id');
    element = $("##{id}").find('.order-state');

    newState = if element.data('state') == 'delivered' then 'pending' else 'delivered'

    $.ajax "/api/orders/#{id}",
      type: 'PUT'
      dataType: 'json'
      data: {
        order: {
          state: newState
        }
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        element.data('state', newState).html(newState)

buildGetUrl = ->
  selectValue = $('#stateSelect').val();

  if selectValue == 'pending' || selectValue == 'delivered'
    "/api/orders?state=#{selectValue}"
  else
    "/api/orders"
