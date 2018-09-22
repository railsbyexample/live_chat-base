import React from 'react'
import PropTypes from 'prop-types'
import { Avatar, Card, Button, Form, Input } from 'antd';

import Cable from '../../services/Cable'

import AvatarHeader from '../../components/AvatarHeader'
import MessageBox from '../../components/MessageBox'

const InputGroup = Input.Group
const TextArea = Input.TextArea
const FormItem = Form.Item
const Meta = Card.Meta

class Show extends React.Component {
  constructor(props) {
    super(props)

    this.scrollRef = React.createRef()

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleEnter = this.handleEnter.bind(this)
    this.sendMessage = this.sendMessage.bind(this)

    this.state = {
      message: '',
      messages: JSON.parse(this.props.messages),
      conversation: JSON.parse(this.props.conversation)
    }
  }

  componentDidMount() {
    this.messagesSubscription = Cable.subscriptions.create(
      { channel: 'UsersChannel' },
      { received: data => { this.handleMessageReceived(JSON.parse(data.message)) } }
    )

    setTimeout(() => { this.scrollRef.current.scrollIntoView() }, 3000)
  }

  componentWillUnmount() {
    document.removeEventListener('message-received', this.handleMessageReceived.bind(this))
  }

  handleChange({ target }) {
    this.setState({ message: target.value })
  }

  handleSubmit(event) {
    event.preventDefault()
    this.sendMessage(this.state.message)
    this.setState({ message: '' })
  }

  handleMessageReceived(message) {
    if (message.conversation_id == this.props.conversation_id) {
      const messages = this.state.messages.concat(message)
      this.setState({ messages })
      this.scrollRef.current.scrollIntoView({ behavior: 'smooth' })
    }
  }

  handleEnter(event) {
    if (event.which == 13) {
      event.preventDefault()
      this.handleSubmit({ target: event.target.form, preventDefault: () => {} })
    }
  }

  sendMessage(message) {
    this.messagesSubscription.perform('send_message',
      { body: this.state.message, conversation_id: this.props.conversation_id }
    )
  }

  render () {
    let userMessageMargin = (message) => (message.user_id == this.props.current_user_id ? 'ml-5' : 'mr-5')
    let userMessageBackground = (message) => (message.user_id == this.props.current_user_id ? { backgroundColor: '#eee' } : {})

    const otherUser = this.state.conversation.user_1_id == this.props.current_user_id
      ? this.state.conversation.user_2
      : this.state.conversation.user_1

    return (
      <div className="container">
        <AvatarHeader
          imageUrl={otherUser.gravatar_url}
          title={otherUser.name}
          description={otherUser.email}
        />

        {this.state.messages.map(message => (
          <MessageBox
            key={message.id}
            imageUrl={message.user.gravatar_url}
            text={message.body}
            received={!(message.user_id == this.props.current_user_id)}
          />
        ))}

        <div ref={this.scrollRef} />

        <div className="fixed-bottom container py-2 bg-white">
          <form onSubmit={this.handleSubmit} className="d-flex align-items-stretch">
            <textarea
              placeholder="Enter message"
              className="w-100 textarea"
              onChange={this.handleChange}
              onKeyPress={this.handleEnter}
              value={this.state.message}
              style={{ height: '120px' }}
            />

            <button className="btn btn-underline" type="submit">
              <img src={this.props.add_conversation_icon} />
            </button>
          </form>
        </div>
        <div style={{width: '100%', height: '120px' }} />
      </div>
    );
  }
}

export default Show
