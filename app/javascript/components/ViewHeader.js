import React from 'react'

const ViewHeader = ({ title, children }) => (
  <div className="mb-4 d-flex align-items-center justify-content-between">
    <h4 className="font-weight-bold text-primary mb-0">{title}</h4>
    {children}
  </div>
)

export default ViewHeader
