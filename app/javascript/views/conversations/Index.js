import React from 'react'
import PropTypes from 'prop-types'
import { Avatar, Divider, Card, Button, Form, Input, Row, Col } from 'antd';

import Cable from '../../services/Cable'
import Auth from '../../services/Auth'

const InputGroup = Input.Group
const TextArea = Input.TextArea
const FormItem = Form.Item
const Meta = Card.Meta

class Index extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      conversations: JSON.parse(this.props.conversations)
    }
  }

  handleSubmit() {
    this.formRef.current.submit()
  }

  render () {
    const senderString = (conversation) => {
      return conversation.last_message.user_id == conversation.user_1_id
      ? `${conversation.user_1.name}: `
      : `${conversation.user_2.name}: `
    }

    const otherUser = (conversation) => {
      return conversation.user_1_id == this.props.current_user_id
      ? conversation.user_2
      : conversation.user_1
    }
    return (
      <div className="container">
        <div className="mb-3" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <h5 className="mb-0">Chats</h5>
          <Button href="/users">New</Button>
        </div>
        {this.state.conversations.map(conversation => (
          <div key={conversation.id} className={`ant-card-compact mb-1`}>
            <a href={`/conversations/${conversation.id}`}>
              <Card style={{ cursor: 'pointer' }} onClick={this.handleSubmit}>
                <Meta
                  avatar={<Avatar src={otherUser(conversation).gravatar_url} />}
                  description={otherUser(conversation).email}
                />
                {senderString(conversation)}{conversation.last_message.body}
              </Card>
            </a>
          </div>
        ))}
      </div>
    );
  }
}

export default Index
