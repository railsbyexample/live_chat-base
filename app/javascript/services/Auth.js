const getAuthenticityToken = () => document.querySelector('meta[name=csrf-token]').getAttribute('content')
const Auth = { getAuthenticityToken }

export default Auth
