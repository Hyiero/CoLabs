anyEmailVerified = (user) ->
  ( user?.emails?.filter (e) -> e.verified )?.length > 0

@CoLabs.isVerifiedUser = -> anyEmailVerified Meteor.user()

@CoLabs.isAdmin = -> Meteor.user()?.isAdmin?

@CoLabs.encodeAsHexMd5 = (text) -> CryptoJS.MD5(text).toString()
