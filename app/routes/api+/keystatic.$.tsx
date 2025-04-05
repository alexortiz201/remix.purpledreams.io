import { handleLoader } from '@keystatic/remix/api'
import { type ActionFunction, type LoaderFunction } from 'react-router'
import config from '#/keystatic.config'
import { requireUserWithRole } from '#app/utils/permissions.server.ts'

export const loader: LoaderFunction = async (args) => {
  await requireUserWithRole(args.request, 'admin')
  return handleLoader({ config }, { ...args })
}
export const action: ActionFunction = async (args) => {
  await requireUserWithRole(args.request, 'admin')
  return handleLoader({ config }, { ...args })
}