const getCurrentUser = () => document.querySelector('meta[name=current_user]').getAttribute('content')
const CurrentUser = { getCurrentUser }

export default CurrentUser
