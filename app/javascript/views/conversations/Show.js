import React from 'react'
import PropTypes from 'prop-types'
import { Avatar, Card, Button, Form, Input } from 'antd';

const InputGroup = Input.Group
const FormItem = Form.Item
const Meta = Card.Meta

class Show extends React.Component {
  constructor(props) {
    super(props)

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.sendMessage = this.sendMessage.bind(this)

    this.state = {
      message: '',
      messages: JSON.parse(this.props.messages)
    }
  }

  componentDidMount() {
    document.addEventListener('message-received', this.handleMessageReceived.bind(this), this)
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

  handleMessageReceived() {
    console.log(App.last_message)
  }

  sendMessage(message) {
    App.global_messages.send_message(this.state.message, 1)
  }

  render () {
    return (
      <div className="container">
        {this.state.messages.map(message => (
          <div key={message.id} className='ant-card-compact mb-1'>
            <Card>
              <Meta
                avatar={<Avatar src={message.user.gravatar_url} />}
                description={message.user.name}
              />
              {message.body}
            </Card>
          </div>
        ))}

        <Form layout="horizontal" onSubmit={this.handleSubmit}>
          <FormItem>
            <InputGroup compact>
              <Input
                style={{ width: '80%' }}
                placeholder="Enter message"
                onChange={this.handleChange}
                value={this.state.message}
              />

              <Button style={{ width: '20%' }} htmlType="submit">Send</Button>
            </InputGroup>
          </FormItem>
        </Form>
      </div>
    );
  }
}

export default Show
