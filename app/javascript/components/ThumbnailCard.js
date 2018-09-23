import React from 'react'
import Auth from '../services/Auth'

const ClickWrapper = ({ href, onClick, children }) => {
  if (href) { return <a href={href}>{children}</a> }
  if (onClick) { return <div onClick={onClick}>{children}</div> }
  return <div>{children}</div>
}

const ThumbnailCard = ({ children, deleteAction, deleteIcon, imageUrl, href, onClick, title, description }) => (
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

      {
        deleteAction
        ? <form action={deleteAction} method="post">
            <input name="utf8" type="hidden" value="✓" />
            <input name="_method" type="hidden" value="delete" />
            <input name="authenticity_token" type="hidden" value={Auth.getAuthenticityToken()} />
            <button type="submit" className="btn btn-clear">
              <img src={deleteIcon} style={{ width: '24px' }} />
            </button>
          </form>
        : null
      }
      {children}
    </div>
  </div>
)

export default ThumbnailCard
