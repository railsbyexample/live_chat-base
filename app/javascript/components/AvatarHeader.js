import React from 'react'

const AvatarHeader = ({ imageUrl, title, description }) => (
  <div className="card border-0 sticky-top bg-white mb-3">
    <div className="card-body d-flex align-items-center">
      <img className="avatar avatar-lg" src={imageUrl} />

      <div className="px-3">
        <h5 className="mb-0 text-primary font-weight-bold">{title}</h5>
        <div className="text-primary">{description}</div>
      </div>
    </div>
  </div>
)

export default AvatarHeader
