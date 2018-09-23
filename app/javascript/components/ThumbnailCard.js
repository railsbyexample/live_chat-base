import React from 'react'

const ClickWrapper = ({ href, onClick, children }) => {
  if (href) { return <a href={href}>{children}</a> }
  if (onClick) { return <div onClick={onClick}>{children}</div> }
  return <div>{children}</div>
}

const ThumbnailCard = ({ children, deleteIcon, imageUrl, href, onClick, title, description }) => (
  <div className="card mb-3">
    <div className="card-body d-flex justify-content-between align-items-end" style={{ cursor: 'pointer' }}>
      <ClickWrapper href={href} onClick={onClick}>
        <div className="d-flex align-items-center">
          <img className="avatar" src={imageUrl} />

          <div className="px-3">
            <div className="text-primary font-weight-bold">{title}</div>
            <div className="text-primary">{description}</div>
          </div>
        </div>
      </ClickWrapper>

      <a href='#'>
        <img className="avatar" src={deleteIcon} style={{ width: '24px' }} />
      </a>
      {children}
    </div>
  </div>
)

export default ThumbnailCard
