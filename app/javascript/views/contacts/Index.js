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
      contacts: JSON.parse(this.props.contacts)
    }
  }

  handleSubmit() {
    this.formRef.current.submit()
  }

  render () {
    const { current_user_id, add_user_icon, delete_icon } = this.props
    const { users } = this.state

    const senderString = (contact) => {
      return contact.last_message.user_id == contact.sender_id
      ? `${contact.sender.name}: `
      : `${contact.receiver.name}: `
    }

    const otherUser = (contact) => {
      return contact.sender_id == this.props.current_user_id
      ? contact.receiver
      : contact.sender
    }

    return (
      <div className="container">
        <ViewHeader title="Chats">
          <LinkButton
            text="Add"
            href="/contacts/new"
            src={add_user_icon}
          />
        </ViewHeader>

        {this.state.contacts.map(contact => (
          <div key={contact.id}>
            <ThumbnailCard
              key={contact.id}
              deleteIcon={delete_icon}
              imageUrl={otherUser(contact).gravatar_url}
              title={otherUser(contact).name}
              description={contact.last_message && `${senderString(contact)}${contact.last_message.body}`}
              href={`/contacts/${contact.id}`}
              onClick={() => { this.handleSubmit(user.id) }}
            />
          </div>
        ))}
      </div>
    );
  }
}

export default Index
