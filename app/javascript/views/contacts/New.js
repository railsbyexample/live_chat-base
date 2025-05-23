import React from 'react'
import PropTypes from 'prop-types'

import Cable from '../../services/Cable'
import Auth from '../../services/Auth'
import CurrentUser from '../../services/CurrentUser'
import Icons from '../../services/Icons'

import ViewHeader from '../../components/ViewHeader'
import LinkButton from '../../components/LinkButton'
import ThumbnailCard from '../../components/ThumbnailCard'

class New extends React.Component {
  constructor(props) {
    super(props)

    const unconfirmed_contacts = JSON.parse(this.props.unconfirmed_contacts)
    const current_user = JSON.parse(CurrentUser.getCurrentUser())

    this.state = {
      sentContacts: unconfirmed_contacts.filter(({ sender_id }) => sender_id === current_user.id),
      receivedContacts: unconfirmed_contacts.filter(({ receiver_id }) => receiver_id === current_user.id),
      current_user
    }
  }

  render () {
    const { sentContacts, receivedContacts } = this.state

    const otherUser = (contact) => {
      return contact.sender_id == this.state.current_user.id
      ? contact.receiver
      : contact.sender
    }

    return (
      <div className="container">
        <h5>Add people</h5>
        <form action="/contacts" method="post">
          <input name="authenticity_token" type="hidden" value={Auth.getAuthenticityToken()} />
          <div className="form-group">
            <label htmlFor="contact[email]">Email</label>
            <input name="contact[email]" type="email" className="form-control" />
          </div>
          <div className="form-group">
            <button type="submit" className="btn btn-primary btn-block">
              Request contact
            </button>
          </div>
        </form>

        {receivedContacts.length > 0 ? <h5>Pending your approval</h5> : null}
        {receivedContacts.map(contact => (
          <ThumbnailCard
            key={otherUser(contact).id}
            imageUrl={otherUser(contact).gravatar_url}
            title={otherUser(contact).name}
            description={otherUser(contact).email}
          >
            <form action={`/contacts/${contact.id}`} acceptCharset="UTF-8" method="post">
              <input name="utf8" type="hidden" value="✓" />
              <input name="_method" type="hidden" value="patch" />
              <input name="authenticity_token" type="hidden" value={Auth.getAuthenticityToken()} />
              <button type="submit" className="btn btn-clear">
                <img src={Icons.confirm_icon} />
              </button>
            </form>
          </ThumbnailCard>
        ))}

        {sentContacts.length > 0 ? <h5>Pending other's approval</h5> : null}
        {sentContacts.map(contact => (
          <ThumbnailCard
            key={otherUser(contact).id}
            imageUrl={otherUser(contact).gravatar_url}
            title={otherUser(contact).name}
            description={otherUser(contact).email}
          />
        ))}
      </div>
    );
  }
}

export default New
