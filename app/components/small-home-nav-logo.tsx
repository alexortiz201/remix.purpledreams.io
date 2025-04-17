import { Link } from 'react-router'

export function SmallNavLogo() {
  return (
    <Link to="/" className="group grid leading-snug">
      <span className="font-light transition group-hover:-translate-x-1">
        purple
      </span>
      <span className="font-bold transition group-hover:translate-x-1">
        dreams
      </span>
    </Link>
  )
}