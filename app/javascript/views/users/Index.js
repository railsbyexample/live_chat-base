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

  handleSubmit() {
    this.formRef.current.submit()
  }

  render () {
    return (
      <div className="container">
        <div className="mb-3" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <h5 className="mb-0">Users</h5>
          <Button href="/users/invitation/new">Invite</Button>
        </div>
        {this.state.users.map(user => (
          <div key={user.id} className={`ant-card-compact mb-1`}>
            <form method="post" action="/conversations" ref={this.formRef}>
              <input type="hidden" name="authenticity_token" value={Auth.getAuthenticityToken()} />
              <input type="hidden" name="conversation[user_1_id]" value={this.props.current_user_id} />
              <input type="hidden" name="conversation[user_2_id]" value={user.id} />
              <Card style={{ cursor: 'pointer' }} onClick={this.handleSubmit}>
                <Meta
                  avatar={<Avatar src={user.gravatar_url} />}
                  description={user.email}
                />
                {user.name}
              </Card>
            </form>
          </div>
        ))}
      </div>
    );
  }
}

export default Index
