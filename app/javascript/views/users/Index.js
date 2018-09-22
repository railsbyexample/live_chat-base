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
    return (
      <div className="container">
        <div className="mb-4 d-flex align-items-center justify-content-between">
          <h4 className="font-weight-bold text-primary mb-0">Users</h4>
          <a href="/users/invitation/new" className="btn btn-underline d-flex align-items-center">
            <span className="mr-2 text-primary">Invite</span>
            <img src={this.props.add_user_icon} style={{ width: '24px' }} />
          </a>
        </div>

        {this.state.users.map(user => (
          <div key={user.id} className="card mb-3">
            <div
              className="card-body d-flex justify-content-between align-items-end"
              style={{ cursor: 'pointer' }}
              onClick={() => { this.handleSubmit(user.id) }}
            >
              <div className="d-flex align-items-center">
                <img className="avatar" src={user.gravatar_url} />

                <div className="px-3">
                  <div className="text-primary font-weight-bold">{user.name}</div>
                  <div className="text-primary">{user.email}</div>
                </div>
              </div>

              <a href='#'>
                <img className="avatar" src={this.props.delete_icon} style={{ width: '24px' }} />
              </a>
            </div>
          </div>
        ))}

        <form method="post" action="/conversations" ref={this.formRef}>
          <input type="hidden" name="authenticity_token" value={Auth.getAuthenticityToken()} />
          <input type="hidden" name="conversation[user_1_id]" value={this.props.current_user_id} />
          <input type="hidden" name="conversation[user_2_id]" />
        </form>
      </div>
    );
  }
}

export default Index
