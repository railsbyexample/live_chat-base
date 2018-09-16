import ActionCable from 'actioncable'

const wsHost = document.querySelector('meta[name=ws-host]').getAttribute('content')
const Cable = ActionCable.createConsumer(wsHost)

export default Cable
