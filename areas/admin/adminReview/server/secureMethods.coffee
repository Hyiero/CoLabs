CoLabs.methods
  updateTag: (obj)->
    Tags.update obj.tagId, $set:
      status: obj.status