CoLabs.methods
  updateProject: (obj)->
    Projects.update obj.id, $set:
      name: obj.name
      description: obj.description
      skills: obj.skills
      interests: obj.interests