const getCurrentUser = () => {
  const userIsSignedIn = document.querySelector('meta[name=user_signed_in]').getAttribute('content')

  if (userIsSignedIn == "true") {
    return document.querySelector('meta[name=current_user]').getAttribute('content')
  }
}

const CurrentUser = { getCurrentUser }

export default CurrentUser
