import { handleLoader } from '@keystatic/remix/api'
import { type ActionFunction, type LoaderFunction } from 'react-router'
import config from '#/keystatic.config'

export const loader: LoaderFunction = args => handleLoader({ config }, { ...args })
export const action: ActionFunction = args => handleLoader({ config }, { ...args })