INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES

-- 1. Not handling async errors
('How to return errors from Zustand store', 'react', 'HIGH', '[{"solution": "Store error state in Zustand along with successful state", "percentage": 90}, {"solution": "Use set() to store error in catch block of async action", "percentage": 85}]'::jsonb, 'Zustand store with async functions', 'Error message displayed to user', 'Trying to return error directly instead of storing in state', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/72426995/how-to-return-errors-from-zustand-store', 'admin:1764225696'),

-- 2. Error handling pattern in async functions
('How to show error to user using React and Zustand', 'react', 'HIGH', '[{"solution": "Create global error store with setError function", "percentage": 92}, {"solution": "Use get() inside catch block to call error setter", "percentage": 88}]'::jsonb, 'Zustand store, error display component', 'Error message shown in UI', 'Calling showError function inside store instead of using state', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/71223523/how-to-show-an-error-to-the-user-using-react-and-zustand-stores', 'admin:1764225696'),

-- 3. TypeScript subscribeWithSelector type errors
('TypeScript Zustand subscribeWithSelector errors', 'typescript', 'MEDIUM', '[{"solution": "Ensure subscribeWithSelector is passed in create() generic type", "percentage": 87}, {"solution": "Use selector function with subscribe method correctly", "percentage": 85}]'::jsonb, 'TypeScript, Zustand v4+', 'Store compiles without type errors', 'Incorrect middleware type parameter ordering', 0.86, 'haiku', NOW(), 'https://stackoverflow.com/questions/77190365/typescript-zustand-subscribewithselector-errors', 'admin:1764225696'),

-- 4. State not updating with getState()
('Zustand is not updating the state', 'react', 'HIGH', '[{"solution": "Use hook instead of getState() in components: const {authToken, setAuthToken} = useAuthToken()", "percentage": 95}, {"solution": "If using getState(), component won''t re-render on state changes", "percentage": 93}]'::jsonb, 'Zustand store, React component', 'State updates trigger re-renders', 'Using getState() in component instead of hook', 0.94, 'haiku', NOW(), 'https://stackoverflow.com/questions/75692454/zustand-is-not-updating-the-state', 'admin:1764225696'),

-- 5. Next.js SSR hydration mismatch with persist
('Next.js Zustand persist hydration error', 'react', 'MEDIUM', '[{"solution": "Use skipHydration: true in persist config, then call rehydrate() in useEffect", "percentage": 91}, {"solution": "Load from localStorage only after component mounts with useEffect", "percentage": 89}]'::jsonb, 'Next.js 13.4+, Zustand persist', 'Hydration succeeds, state persists', 'Persist initializing during SSR renders', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/72649255/nextjs-zustand-persist-state', 'admin:1764225696'),

-- 6. TypeScript persist middleware type errors
('TypeScript error with Zustand persist middleware StateCreator', 'typescript', 'MEDIUM', '[{"solution": "Use StateCreator generic with middleware array: StateCreator<Store, [[\"zustand/persist\", unknown]]]", "percentage": 86}, {"solution": "Add () after create() like: create<Store>()(persist(...))", "percentage": 93}]'::jsonb, 'TypeScript, Zustand v4+', 'Store compiles without type errors', 'Missing () in create or incorrect middleware type', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/76744178/typescript-error-with-zustands-persist-middleware-and-statecreator-in-react-app', 'admin:1764225696'),

-- 7. Persist middleware losing functions
('Zustand persist middleware functions disappear after reload', 'react', 'MEDIUM', '[{"solution": "Define all reducer functions at top level of store config", "percentage": 88}, {"solution": "Use partialize option to specify which state to persist, not functions", "percentage": 90}]'::jsonb, 'Zustand with persist middleware', 'Functions available after browser reload', 'Wrapping reducers in objects or persisting them', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/76801357/there-seems-to-be-a-problem-with-the-zustand-persist-function', 'admin:1764225696'),

-- 8. Creating store at component level
('Zustand store created at component level not updating', 'react', 'HIGH', '[{"solution": "Create store at module level, not inside component", "percentage": 96}, {"solution": "Component re-renders create new store instance, losing previous state", "percentage": 94}]'::jsonb, 'Zustand, React component', 'State persists across renders', 'Calling create() inside component render', 0.95, 'haiku', NOW(), 'https://stackoverflow.com/questions/74990931/having-issue-in-using-zustand-to-keep-state-updated', 'admin:1764225696'),

-- 9. Unnecessary re-renders with functions
('Zustand component re-renders on scroll despite unchanged state', 'react', 'MEDIUM', '[{"solution": "Use selector to extract function: const tempBtn = stateButton((state) => state.setBtn)", "percentage": 87}, {"solution": "Don''t use whole store, extract only needed parts", "percentage": 89}]'::jsonb, 'Zustand store, event handler', 'No re-renders when state unchanged', 'Passing entire store to component', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/68467412/why-using-state-manager-like-zustand-component-still-re-renders', 'admin:1764225696'),

-- 10. Selector causing re-renders
('Zustand component re-renders although value unchanged', 'react', 'MEDIUM', '[{"solution": "Create new objects in selectors causes re-renders, use useShallow() or useMemo", "percentage": 91}, {"solution": "Don''t spread or create new objects in selector function", "percentage": 93}]'::jsonb, 'Zustand with selectors', 'Component re-renders only when selected value changes', 'Returning new object from selector', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/77894421/component-is-re-rendering-although-value-in-zustand-store-do-not-change', 'admin:1764225696'),

-- 11. Infinite re-render loops
('Infinite re-render using Zustand with useEffect', 'react', 'MEDIUM', '[{"solution": "Remove action function from useEffect dependency array", "percentage": 92}, {"solution": "Use useRef to store action, or use useCallback to memoize", "percentage": 89}]'::jsonb, 'Zustand with async actions, useEffect', 'Effect runs once or limited times', 'Including action in dependency array', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/73147257/infinite-re-render-using-zustand', 'admin:1764225696'),

-- 12. Devtools with multiple stores
('How to handle multiple Zustand stores in browser devtools', 'react', 'LOW', '[{"solution": "Add name and store properties to devtools: devtools(..., {name, store: storeName})", "percentage": 88}, {"solution": "Use slices pattern to combine stores in one devtools instance", "percentage": 86}]'::jsonb, 'Zustand with devtools', 'Both stores visible in browser devtools', 'Using devtools without store name parameter', 0.87, 'haiku', NOW(), 'https://stackoverflow.com/questions/77406827/how-to-handle-more-than-one-zustand-store-into-the-browser-devtools', 'admin:1764225696'),

-- 13. TypeScript devtools middleware errors
('How to use Zustand devtools with TypeScript', 'typescript', 'MEDIUM', '[{"solution": "Add () after create like: create<Store>()(devtools(...))", "percentage": 94}, {"solution": "Ensure type parameter is before middleware call", "percentage": 91}]'::jsonb, 'TypeScript, Zustand v4+', 'Store compiles with devtools', 'Missing () between create and middleware', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/74223036/how-to-use-zustand-devtools-with-typescript', 'admin:1764225696'),

-- 14. Persist middleware storage unavailable error
('Zustand persist middleware storage unavailable error', 'react', 'MEDIUM', '[{"solution": "Replace deprecated getStorage with storage: createJSONStorage()", "percentage": 91}, {"solution": "Use createJSONStorage(() => AsyncStorage) for React Native", "percentage": 88}]'::jsonb, 'Zustand with persist, React Native', 'No storage errors, state persists', 'Using deprecated getStorage parameter', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/72311639/unable-to-use-zustand-persist-middleware', 'admin:1764225696'),

-- 15. Context loss with multiple instances
('Zustand store inside React Context losing state', 'react', 'MEDIUM', '[{"solution": "Use useRef to create store once in provider, not recreate on render", "percentage": 89}, {"solution": "Use selector in useLikesContext hook, not return whole store", "percentage": 87}]'::jsonb, 'Zustand with React Context', 'Store maintains state across provider renders', 'Creating store inside provider without useRef', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/78858156/can-i-use-a-zustand-store-inside-a-react-context-to-create-multiple-instances-of', 'admin:1764225696')

ON CONFLICT DO NOTHING;
