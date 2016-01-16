module.exports = function select(selector) {

  console.log(client)

  var elems = client.elements(selector)

  client.log(elems)

  if (elems.value.length === 1)
    return elems.value[0].ElEMENT

  else {
    list = elems.value
    results = []

    for (var i = 0; i < list.length; i++)
      results.push(list[i].ELEMENT)

    return results
  }

}