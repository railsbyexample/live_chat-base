import React from 'react'

const MessageBox = ({ imageUrl, text, received }) => (
  <div className={`card mb-3 ${received ? 'mr-5' : 'ml-5'}`}>
    <div className={`card-body align-items-start d-flex ${received ? '' : 'justify-content-between bg-white'}`}>
      { received ? <img src={imageUrl} className="avatar avatar-sm"/> : null }
      <div className="px-3"><p className="mb-1">{text}</p></div>
      { received ? null : <img src={imageUrl} className="avatar avatar-sm"/> }
    </div>
  </div>
)

export default MessageBox
