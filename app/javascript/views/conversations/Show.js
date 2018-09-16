import React from 'react'
import PropTypes from 'prop-types'
import { Avatar, Card, Button, Form, Input } from 'antd';

import Cable from '../../services/Cable'

const InputGroup = Input.Group
const TextArea = Input.TextArea
const FormItem = Form.Item
const Meta = Card.Meta

class Show extends React.Component {
  constructor(props) {
    super(props)

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleEnter = this.handleEnter.bind(this)
    this.sendMessage = this.sendMessage.bind(this)

    this.state = {
      message: '',
      messages: JSON.parse(this.props.messages)
    }
  }

  componentDidMount() {
    this.messagesSubscription = Cable.subscriptions.create(
      { channel: 'UsersChannel' },
      { received: data => { this.handleMessageReceived(JSON.parse(data.message)) } }
    )
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

    return (
      <div className="container">
        {this.state.messages.map(message => (
          <div key={message.id} className={`ant-card-compact mb-1 ${userMessageMargin(message)}`}>
            <Card style={userMessageBackground(message)}>
              <Meta
                avatar={<Avatar src={message.user.gravatar_url} />}
                description={message.user.name}
              />
              {message.body}
            </Card>
          </div>
        ))}

        <div className="pt-3" style={{ backgroundColor: 'white', position: 'fixed', bottom: 0, left: 0, right: 0 }}>
          <Form layout="horizontal" onSubmit={this.handleSubmit}>
            <FormItem>
              <InputGroup compact>
                <TextArea
                  style={{ width: '80%', height: '94px' }}
                  placeholder="Enter message"
                  onChange={this.handleChange}
                  onKeyPress={this.handleEnter}
                  value={this.state.message}
                />

                <Button style={{ width: '20%', height: '94px' }} htmlType="submit">Send</Button>
              </InputGroup>
            </FormItem>
          </Form>
        </div>
        <div style={{width: '100%', height: '134px' }} />
      </div>
    );
  }
}

export default Show
