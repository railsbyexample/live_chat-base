import React from 'react'
import PropTypes from 'prop-types'
import { Avatar, Divider, Card, Button, Form, Input, Row, Col } from 'antd';

import Cable from '../../services/Cable'
import Auth from '../../services/Auth'

import ViewHeader from '../../components/ViewHeader'
import LinkButton from '../../components/LinkButton'
import ThumbnailCard from '../../components/ThumbnailCard'

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
    const { current_user_id, add_conversation_icon, delete_icon } = this.props
    const { users } = this.state

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
        <ViewHeader title="Conversations">
          <LinkButton
            text="New"
            href="/users"
            src={add_conversation_icon}
          />
        </ViewHeader>
        {this.state.conversations.map(conversation => (

          <div key={conversation.id}>
            <ThumbnailCard
              key={conversation.id}
              deleteIcon={delete_icon}
              imageUrl={otherUser(conversation).gravatar_url}
              title={otherUser(conversation).name}
              description={`${senderString(conversation)}${conversation.last_message.body}`}
              href={`/conversations/${conversation.id}`}
              onClick={() => { this.handleSubmit(user.id) }}
            />
          </div>
        ))}
      </div>
    );
  }
}

export default Index
