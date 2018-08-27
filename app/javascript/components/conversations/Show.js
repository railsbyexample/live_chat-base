import React from 'react'
import PropTypes from 'prop-types'
import Button from 'antd/lib/button'

class Show extends React.Component {
  render () {
    return (
      <div className="container">
        <Button type="primary">
          Test AntD Button
        </Button>
      </div>
    );
  }
}

export default Show
