import React from 'react'
import { Avatar, Menu, Icon } from 'antd';

const SubMenu = Menu.SubMenu;
const MenuItemGroup = Menu.ItemGroup;

class Navbar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentUser: JSON.parse(this.props.current_user)
    }
  }
  render() {
    return(
      <div style={{ position: 'relative', zIndex: 2 }}>
        <div style={{ backgroundColor: 'white', position: 'fixed', top: 0, left: 0, right: 0 }} className="container py-3">
          <div className="row">
            <div className="col-12 col-md-3">
              <h5 className="mb-0">MessRb</h5>
            </div>

          {this.state.currentUser
            ? <div className="col-12 col-md-9 d-flex justify-content-end">
                <Menu mode="horizontal">
                  <Menu.Item key="chats">
                    <a href="/conversations">
                      <Icon type="message" />Chats
                    </a>
                  </Menu.Item>
                  <Menu.Item key="users">
                    <a href="/users">
                      <Icon type="team" />Users
                    </a>
                  </Menu.Item>
                  <Menu.Item key="profile">
                    <a href="/users/edit">
                      <Avatar src={this.state.currentUser.gravatar_url} />
                    </a>
                  </Menu.Item>
                </Menu>
              </div>
            : null}
          </div>
        </div>
        <div className="d-none d-md-block" style={{ width: '100%', height: '80px' }} />
        <div className="d-block d-md-none" style={{ width: '100%', height: '104px' }} />
      </div>
    )
  }
}

export default Navbar
