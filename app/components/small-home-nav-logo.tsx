import { Link } from 'react-router'

export function SmallNavLogo() {
  return (
    <Link to="/" className="group grid leading-snug">
      <span className="font-light transition group-hover:-translate-x-1">
        salon
      </span>
      <span className="font-bold transition group-hover:translate-x-1">
        expo
      </span>
    </Link>
  )
}