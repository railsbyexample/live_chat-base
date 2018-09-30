import ActionCable from 'actioncable'

const wsHost = document.querySelector('meta[name=action-cable-url]').getAttribute('content')
const Cable = ActionCable.createConsumer(wsHost)

export default Cable
