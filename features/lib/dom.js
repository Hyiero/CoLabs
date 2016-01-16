module.exports = dom = {

  click: function (elem) {
    return client.click(elem)
  },

  hover: function (elem, time) {
    return client.moveToObject(elem)
  },

  isPresent: function (elem) {
    return client.isExisting(elem)
  },

  isShowing: function (elem) {
    return client.isVisible(elem)
  },

  append: function (elem, text) {
    return client.addValue(elem, text)
  },

  set: function (elem, text) {

    return client.setValue(elem, text)
  }

}