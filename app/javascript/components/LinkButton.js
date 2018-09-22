import React from 'react'

const LinkButton = ({ href, text, src }) => (
  <a href={href} className="btn btn-underline d-flex align-items-center">
    <span>{text}</span>
    { src ? <img className="ml-2" src={src} style={{ width: '24px' }} /> : null}
  </a>
)

export default LinkButton
