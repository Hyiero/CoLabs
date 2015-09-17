Template.loading.helpers
  icon: ->
    chance = Math.floor Math.random() * 100
    if chance == 0 then "empire"
    else if chance == 1 then "rebel"
    else if chance == 2 then "smile-o"
    else if chance == 3 then "globe"
    else if chance == 4 then "flask"
    else if chance == 5 then "child"
    else if chance == 6 then "wheelchair"
    else if chance == 7 then "beer"
    else "spinner"