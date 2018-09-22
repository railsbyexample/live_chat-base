import React from 'react'
import PropTypes from 'prop-types'

import Cable from '../../services/Cable'
import Auth from '../../services/Auth'

import ViewHeader from '../../components/ViewHeader'
import LinkButton from '../../components/LinkButton'
import ThumbnailCard from '../../components/ThumbnailCard'

class Index extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      users: JSON.parse(this.props.users)
    }

    this.formRef = React.createRef()
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleSubmit(userId) {
    const form = this.formRef.current
    const userInput = form.querySelector("input[name='conversation[user_2_id]']")

    userInput.value = userId
    this.formRef.current.submit()
  }

  render () {
    const { current_user_id, add_user_icon, delete_icon } = this.props
    const { users } = this.state

    return (
      <div className="container">
        <ViewHeader title="Users">
          <LinkButton
            text="Invite"
            href="/users"
            src={add_user_icon}
          />
        </ViewHeader>

        {users.map(user => (
          <ThumbnailCard
            key={user.id}
            deleteIcon={delete_icon}
            imageUrl={user.gravatar_url}
            title={user.name}
            description={user.email}
            onClick={() => { this.handleSubmit(user.id) }}
          />
        ))}

        <form method="post" action="/conversations" ref={this.formRef}>
          <input type="hidden" name="authenticity_token" value={Auth.getAuthenticityToken()} />
          <input type="hidden" name="conversation[user_1_id]" value={current_user_id} />
          <input type="hidden" name="conversation[user_2_id]" />
        </form>
      </div>
    );
  }
}

export default Index
