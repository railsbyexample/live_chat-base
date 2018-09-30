import React from 'react'

import CurrentUser from '../services/CurrentUser'
import Icons from '../services/Icons'
import Images from '../services/Images'

class Navbar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      current_user: JSON.parse(CurrentUser.getCurrentUser())
    }
  }

  render() {
    return(
      <div className="container py-3">
        <div className="d-flex justify-content-between align-items-center">
          <div className="d-flex align-items-center">
            <a href="/">
              <img src={this.props.logo} style={{ width: '60px' }} />
              <h5 className="ml-1 mb-0 d-none d-md-inline-block">{this.props.title}</h5>
            </a>
          </div>

          {this.state.current_user
            ? <div className="d-flex justify-content-end">
                <a href="/contacts" className={`btn btn-underline btn-underline-menu ${this.props.active === 'contacts/index' ? 'active' : ''}`} >
                  <img src={Icons.conversations_icon} style={{ width: '36px' }} />
                  <span className="ml-1 d-none d-md-inline-block">Chats</span>
                </a>
                <a href="/contacts/new" className={`btn btn-underline btn-underline-menu ${this.props.active === 'contacts/new' ? 'active' : ''}`} >
                  <img src={Icons.users_icon} style={{ width: '36px' }} />
                  <span className="ml-1 d-none d-md-inline-block">People</span>
                </a>
                <a href="/users/edit" className={`btn btn-underline btn-underline-menu ${this.props.active === 'registrations/edit' ? 'active' : ''}`} >
                  <img src={this.state.current_user.gravatar_url} className="avatar" style={{ width: '36px' }} />
                </a>
              </div>
            : <div className="col-6 col-md-6 d-flex justify-content-end align-items-center">
                <a href="https://perezperret.com" className="mx-2">
                  <img src={Images.perezperret_logo} style={{ width: '36px' }} />
                </a>
                <a href="https://github.com/perezperret/mess-rb" className="mx-2">
                  <img src={Images.github_logo} style={{ width: '36px' }} />
                </a>
              </div>
          }
        </div>
      </div>
    )
  }
}

export default Navbar
