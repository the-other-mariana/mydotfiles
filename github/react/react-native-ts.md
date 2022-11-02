# React Native with Typescript

## Hooks

- `useSelector()`: 
	
	- Allows you to extract data from the Redux store state, using a selector function. Will also subscribe to the Redux store, and run your selector whenever an action is dispatched.

	```typescript
	const result: any = useSelector(selector: Function, equalityFn?: Function)
	```
	with javascript:

	```js
	const name = useSelector((state) => state.name);
	```

	with typescript:

	```typescript
	// pass 2 generics: RootState and what we are expecting: string
	type RootState = ReturnType<typeof store.getState>;
	const name = useSelector<RootState, string>((state) => state.name);
	```

- `useState(value)`:

	- Inside an arrow component, create a state variable with a default or initial value of `value`

	```typescript
	[myStateVar, setMyStateVar] = useState(0); // myStateVar = 0
	```

## Javascript Arrow Functions

```js
// Traditional Anonymous Function
(function (a) {
  return a + 100;
});

// Arrow Function Break Down

// 1. Remove the word "function" and place arrow between the argument and opening body bracket
(a) => {
  return a + 100;
};

// 2. Remove the body braces and word "return" — the return is implied.
(a) => a + 100;

// 3. Remove the argument parentheses
a => a + 100;

// named functions
const bob2 = (a) => a + 100;
bob2(1); // returns 101

(params) => ({ foo: "a" }) // returning the object { foo: "a" }

hello = () => {
  return "Hello World!";
}
```

The { braces } and ( parentheses ) and "return" are required in some cases:

	- For example, if you have multiple arguments or no arguments, you'll need to re-introduce parentheses around the arguments.

	- Likewise, if the body requires additional lines of processing, you'll need to re-introduce braces PLUS the "return" (arrow functions do not magically guess what or when you want to "return")

## Typescript Notes

- Type Assertion 

```typescript
let cid: any = 1
let customerId = <number>cid // option 1
let customerId = cid as number // option 2
```

- Objects

```typescript
type User = {
	id: number
	name: string
}
const user: User = {
	id: 1, 
	name: 'mariana',
}
```

- Interfaces

```typescript
interface UserInterface {
	id: number
	name: string
	age?: number // this is an optional attribute
}
const user1: UserInterface = {
	id: 1,
	name: 'mariana',
}
interface MathFunc {
	(x: number, y: number): number
}
const add: MathFunc = (x: number, y: number): number => x + y
const sub: MathFunc = (x: number, y: number): number => x - y
```

Let's use an interface inside a Component:

```typescript
export interface Props {
	title: string
	color?: string
}
const Header = (props: Props) => {
	return (
		<header>
			<h1 style={{color: props.color ? props.color : 'blue'}}>
				{props.title}
			</h1>
		</header>
	)
}
```

- Classes

```typescript
class Person {
	id: number
	name: string

	constructor(id: number, name: string){
		this.id = id
		this.name = name
	}
}

const mariana = new Person(25, 'mariana');
```
We can also make further classes like: 

```typescript
interface PersonInterface {
	id: number
	name: string
	register(): string
}
class Person implements PersonInterface{
	id: number
	name: string

	// all attributes must be initialized, so let's use a constructor
	constructor(id: number, name: string){
		this.id = id
		this.name = name
	}

	register(){
		return `${this.name} is registered`
	}
}

class Employee extends Person {
	position: string
	
	constructor(id: number, name: string, position: string){
		super(id, name)
		this.position = position
	}
}

const mariana = new Person(25, 'mariana');
const marianaHappy = new Employee(25, 'mariana', 'developer');
console.log(marianaHappy.position);
```


- Generics

Generic Type `T` is just a placeholder for the type you send in the function call:

```typescript
function getArray<T>(items: T[]): T[] {
	return new Array().concat(items)
}
let numArray = getArray<number>([1,2,3])
let strArray = getArray<string>(['mariana', 'luka', 'toni'])

strArray.push('marco');
strArray.push(1); // error
```

- Create react app using typescript

```bash
npx create-react-app my-app --template typescript
```

- If you create a state variable inside a function component, create some functions to update it and pass them as props to other components:

```typescript
const myComp = () => {
	const [item, setItems] = useState([
		{id: uuid(), text: 'Milk'},
		{id: uuid(), text: 'Eggs'}
	]);

	const deleteItem = id => {
		setItems(prevItems => {
			return prevItems.filter(item => item.id != id);
		});
	};

	const addItem = (item) => {
		setItems(prevItems => {
			return [{id:uuid(), text:text}, ...prevItems];
		});
	}
	return (
		<View>
			<TouchableOpacity onPress={deleteItem()}>
			<Text>Delete</Text>
			</TouchableOpacity>
		</View>
	)
}
export default myComp();
```

## Typescript Utility Types

### `<Partial<Type>>`

Constructs a type with all properties of Type set to optional. Opposite of `<Required<Type>>`.

```typescript
interface Todo {
  title: string;
  description: string;
}

function updateTodo(todo: Todo, fieldsToUpdate: Partial<Todo>) {
  return { ...todo, ...fieldsToUpdate };
}
 
const todo1 = {
  title: "organize desk",
  description: "clear clutter",
};
 
const todo2 = updateTodo(todo1, {
  description: "throw out trash",
});
```

### `<ReturnType<typeof func>>`

This just sets the type to the return type of function `func`.

```typescript
const func(a: number): number {
	return abs(a)
}

type absValue = <ReturnType<typeof func>>;
```

would be the same as:

```typescript
type absValue = number; // option 1
type absValue = <ReturnType<() => string>; // option 2
```

## react-navigation or Stack Navigator

Stack Navigator provides a way for your app to transition between screens where each new screen is placed on top of a stack.

```typescript
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

function MyStack() {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Home" component={Home} />
      <Stack.Screen name="Notifications" component={Notifications} />
      <Stack.Screen name="Profile" component={Profile} />
      <Stack.Screen name="Settings" component={Settings} />
    </Stack.Navigator>
  );
}
```

- Props

The `Stack.Navigator` accepts the props: id, initialRouteName, screenOptions, detachInactiveScreens, keyboardHandlingEnabled.

### NavigationContainer

The NavigationContainer is responsible for managing your app state and linking your top-level navigator to the app environment.

```typescript
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>{/* ... */}</Stack.Navigator>
    </NavigationContainer>
  );
}
```

### createStackNavigator()

Provides a way for your app to transition between screens where each new screen is placed on top of a stack.

#### Type checking the navigator

To type check our route name and params, the first thing we need to do is to create an object type with mappings for route name to the params of the route. For example, say we have a route called Profile, Home and Feed in our root navigator which should have a param userId:

```typescript
type RootStackParamList = {
  Home: undefined;
  Profile: { userId: string };
  Feed: { sort: 'latest' | 'top' } | undefined;
};
```

After we have defined the mappings, we need to tell our navigator to use it. To do that, we can pass it as a generic to the createXNavigator functions:

```typescript
import { createStackNavigator } from '@react-navigation/stack';

const RootStack = createStackNavigator<RootStackParamList>();
```

### Screen

Screen components are used to configure various aspects of screens inside a navigator.A Screen is returned from a createXNavigator function:

```typescript
const Stack = createNativeStackNavigator();
<Stack.Navigator>
  <Stack.Screen name="Home" component={HomeScreen} />
  <Stack.Screen name="Profile" component={ProfileScreen} />
</Stack.Navigator>
```
You need to provide at least a name and a component to render for each screen. The name string is used to navigate to that screen, and must coincide with the RootStackParamList attributes' names. The component prop is the React Component to render for the screen. All of the Stack.Screen components will be children of the Stack.Navigation component. By creating a Stack.Screen for Home route, it is the same as:

```typescript
navigation.navigate('Home')}
```

### React Navigation Drawer

Common pattern in navigation is to use drawer from left (sometimes right) side for navigating between screens. It is the menu that unfolds from the left to the right in an app.

```typescript
export type DrawerParamList = {
    CommunityScreen: undefined;
}
const Drawer = createDrawerNavigator<DrawerParamList>();
export const MenuMain = () => {
	return(
		<Drawer.Navigator>
			<Drawer.Screen name='CommunityScreen' component={CommunityScreen}/>
		<Drawer.Navigator/>
	)
}
```

In this case, the unfolded sidebar menu would have one option screen that renders the component CommunityScreen.

### getRootState()

The getRootState method returns a navigation state object containing the navigation states for all navigators in the navigation tree.

```typescript
const state = navigationRef.getRootState();
```

## Interfaces + Objects

### Interface Example

- Inside a ToastMessage.tsx component we receive an object as props with type `Props`, and since we typed `{message, status}: Props`, by using {} we destructure the json object so that instead of having `props: Props` so that we use `props.message`, we now destructured the object there and have `message` directly.

```typescript
interface Props {
    message: string;
    status?: StatusType;
}
function ToastMessage({ message, status }: Props) {
	
	return (
		<Text>{message}<Text/>
	)
}
```

## Spiky Component Structure

- App.ts

```typescript
<Provider store={store}>
        <Container />
</Provider>
```

- Container.tsx

```typescript
<NavigationContainer>
	<Toast>
                <Navigator />
	</Toast>
</NavigationContainer>
```

- Navigator.tsx

```typescript
<Stack.Navigator>
	{!token ? (
                <>
                    <Stack.Screen name="HomeScreen" component={HomeScreen} />
                    <Stack.Screen name="LoginScreen" component={LoginScreen} />
                    <Stack.Screen name="CheckEmailScreen" component={CheckEmailScreen} />
                    <Stack.Screen name="ForgotPwdScreen" component={ForgotPwdScreen} />
                    <Stack.Screen name="RegisterScreen" component={RegisterScreen} />
                    <Stack.Screen name="ManifestPart1Screen" component={ManifestPart1Screen} />
                </>
            ) : (
                <>
                    <Stack.Screen name="MenuMain" component={MenuMain} />
                    <Stack.Screen name="CreateIdeaScreen" component={CreateIdeaScreen} />
                    <Stack.Screen name="OpenedIdeaScreen" component={OpenedIdeaScreen} />
                </>
        )}
<Stack.Navigator/>
```

- MenuMain.tsx

```typescript
<Drawer.Navigator>
	<Drawer.Screen name="CommunityScreen" component={CommunityScreen} />
	<Drawer.Screen name="MyIdeasScreen" component={MyIdeasScreen} />
        <Drawer.Screen name="TrackingScreen" component={TrackingScreen} />
        <Drawer.Screen name="SearchScreen" component={SearchScreen} />
</Drawer.Navigator>
```

- CreateIdeaScreen.tsx

```typescript
<View style={{ height: '40%' }}>
	<TextInput
                placeholder="Perpetua tu idea.."
                placeholderTextColor="#707070"
                style={{ ...styles.textinput, fontSize: 16, fontWeight: '300' }}
                multiline={true}
                onChangeText={value => onChange({ mensaje: value })}
                autoFocus
	/>
	...
<View/>
```

It of course handles a form

```typescript
const { form, onChange } = useForm({
        mensaje: '',
    	});

const { mensaje } = form;
```

that is importing useForm

```typescript
export const useForm = <T extends Object>(initState: T) => {
    const [state, setState] = useState(initState);

    const onChange = (stateUpdated: Partial<T>) => {
        setState({
            ...state,
            ...stateUpdated,
        });
    };

    return {
        ...state,
        form: state,
        onChange,
    };
};
```
So now by having `{mensaje} = form` we are destructuring the return json object from useForm, allowing use to directly type `form` or `onChange()`

- OpenedIdeaScreen.tsx

```typescript
<View>
	{idea.reacciones.length !== 0 ? (
                <>
                    {idea.respuestas.length !== 0 ? (
                        <FlatList
                            style={{ flex: 1, width: '80%', marginTop: 20 }}
                            data={comentarios}
                            renderItem={({ item }) => <Comment comment={item} />}
                            keyExtractor={item => item.id_respuesta + ''}
                            showsVerticalScrollIndicator={false}
                        />
                    ) : (
                        <View style={stylescom.center}>
                            <Text style={{ ...styles.text, ...stylescom.textGrayPad }}>
                                Se el primero en contribuir a esta idea.
                            </Text>
                        </View>
                    )}
                    <InputComment />
                </>
            ) : (
                <View style={stylescom.center}>
                    <Text style={{ ...styles.text, ...stylescom.textGrayPad }}>
                        Toma una postura antes de participar
                    </Text>
                </View>
            )}
</View>
```
where InputComment handles a form (has bug).

### Concepts

- Axios: used for handling http requests with typescript.

```typescript
class SpikyService {
	private instance: AxiosInstance;
	handleForgotPassword(email: string) {
        return this.instance.get<ForgotPasswordResponse>('auth/forgot-password?correo=' + email);
    }
}
```

- AsyncStorage: AsyncStorage is an unencrypted, asynchronous, persistent, key-value storage system that is global to the app. It should be used instead of LocalStorage.

	- To store data:

	```typescript
	await AsyncStorage.setItem(
     		'@MySuperStore:key',
     		'I like to save it.'
   		 );
	```
	- To fetch data:

	```typescript
	const value = await AsyncStorage.getItem('TASKS');
	```
- createSlice: A function that accepts an initial state, an object of reducer functions, and a "slice name", and automatically generates action creators and action types that correspond to the reducers and state.

	- `reducers`: An object containing Redux "case reducer" functions (functions intended to handle a specific action type, equivalent to a single case statement in a switch).

	The keys in the object will be used to generate string action type constants, and these will show up in the Redux DevTools.

	```typescript
	import { createSlice } from '@reduxjs/toolkit'

	const counterSlice = createSlice({
	  name: 'counter',
	  initialState: 0,
	  reducers: {
	    increment: (state) => state + 1,
	    setUser: (state: UserState, action: PayloadAction<UserState>) => {
            	state.nickname = action.payload.nickname;
            	state.notificationsNumber = action.payload.notificationsNumber;
            	state.newChatMessagesNumber = action.payload.newChatMessagesNumber;
            	state.universityId = action.payload.universityId;
            	state.id = action.payload.id;
            }
	  },
	})
	// Will handle the action type `'counter/increment'` and `'counter/setUser'`
	dispatch(
                    setUser({
                        nickname: alias,
                        notificationsNumber: n_notificaciones,
                        newChatMessagesNumber: n_chatmensajes,
                        universityId: id_universidad,
                        id: uid,
                    })
                );
	```
- React Navigation: with the `<NavigationContainer/>` wrapping your whole app, you can now navigate within a stack of screens and handle them just as a browser with the browser history.

createNativeStackNavigator is a function that returns an object containing 2 properties: Screen and Navigator. Both of them are React components used for configuring the navigator. The Navigator should contain Screen elements as its children to define the configuration for routes.

NavigationContainer is a component which manages our navigation tree and contains the navigation state. This component must wrap all navigators structure. Usually, we'd render this component at the root of our app, which is usually the component exported from App.js.

```typescript
const Stack = createNativeStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
```

Now our stack has two routes, a Home route and a Details route. A route can be specified by using the Screen component. The initial route for the stack is the Home route. Try changing it to Details and reload the app. Now you would see first Details screen. How do we move from Home to Details?

```typescript
function HomeScreen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text>Home Screen</Text>
      <Button
        title="Go to Details"
        onPress={() => navigation.navigate('Details')}
      />
    </View>
  );
}
```
would be one option. If we call navigation.navigate with a route name that we haven't defined in a navigator, it'll print an error: we can only navigate to routes that have been defined on our navigator.
[source](https://reactnavigation.org/docs/navigating)

- Drawer-based navigation

This is used to create a navigation drawer menu: those menus that slide open from left to right. First, you need to have a `<NavigationContainer/>` component to contain a drawer menu, and just like with the Stack, there is an object Drawer that has two fields: Navigator and Screen. In Screens you must determine all the possible screens that your drawer may navigate towards. In this case the default or first screen that contains the drawer is Home.

```typescript
function HomeScreen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Button
        onPress={() => navigation.navigate('Notifications')}
        title="Go to notifications"
      />
    </View>
  );
}

function NotificationsScreen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Button onPress={() => navigation.goBack()} title="Go back home" />
    </View>
  );
}
export default function App() {
  return (
    <NavigationContainer>
      <Drawer.Navigator initialRouteName="Home">
        <Drawer.Screen name="Home" component={HomeScreen} />
        <Drawer.Screen name="Notifications" component={NotificationsScreen} />
      </Drawer.Navigator>
    </NavigationContainer>
  );
}
```
In the case of Spiky, we first have a Stack with the Home screen (if there is no token) or the Community screen (if there is token):

```typescript
<Stack.Navigator
            screenOptions={{
                headerShown: false,
                cardStyle: {
                    backgroundColor: 'white',
                },
            }}
        >
            {!token ? (
                <>
                    <Stack.Screen name="HomeScreen" component={HomeScreen} />
                    <Stack.Screen name="LoginScreen" component={LoginScreen} />
                    <Stack.Screen name="CheckEmailScreen" component={CheckEmailScreen} />
                    <Stack.Screen name="ForgotPwdScreen" component={ForgotPwdScreen} />
                    <Stack.Screen name="RegisterScreen" component={RegisterScreen} />
                    <Stack.Screen name="ManifestPart1Screen" component={ManifestPart1Screen} />
                </>
            ) : (
                <>
                    <Stack.Screen name="MenuMain" component={MenuMain} />
                    <Stack.Screen name="CreateIdeaScreen" component={CreateIdeaScreen} />
                    <Stack.Screen name="OpenedIdeaScreen" component={OpenedIdeaScreen} />
                    <Stack.Screen name="ReportIdeaScreen" component={ReportIdeaScreen} />
                    <Stack.Screen name="ReplyIdeaScreen" component={ReplyIdeaScreen} />
                    <Stack.Screen name="ChatScreen" component={ChatScreen} />
                    <Stack.Screen
                        name="TermAndConditionsScreen"
                        component={TermAndConditionsScreen}
                    />
                </>
            )}
</Stack.Navigator>
```

Then, on  `MenuMain.tsx` we got the Drawer creation component,

```typescript
export const MenuMain = () => {
    return (
        <Drawer.Navigator
            screenOptions={{
                drawerType: 'front', // Menú modo horizontal
                headerShown: true,
                header: () => {
                    return <Header />;
                },
                drawerStyle: {
                    backgroundColor: '#F8F8F8',
                    width: '60%',
                },
                /* overlayColor: '#6363635c', */
            }}
            useLegacyImplementation={true}
            drawerContent={props => <MenuInterno {...props} />}
        >
            <Drawer.Screen name="CommunityScreen" component={CommunityScreen} />
            <Drawer.Screen name="MyIdeasScreen" component={MyIdeasScreen} />
            <Drawer.Screen name="TrackingScreen" component={TrackingScreen} />
            <Drawer.Screen name="SearchScreen" component={SearchScreen} />
            <Drawer.Screen name="ConnectionsScreen" component={ConnectionsScreen} />
            <Drawer.Screen
                name="ProfileScreen"
                component={ProfileScreen}
                initialParams={{ alias: 'alias' }}
            />
            <Drawer.Screen name="ConfigurationScreen" component={ConfigurationScreen} />
            <Drawer.Screen name="ChangePasswordScreen" component={ChangePasswordScreen} />
            <Drawer.Screen name="HashTagScreen" component={HashTagScreen} />
        </Drawer.Navigator>
    );
};
```

whose first screen that has the Drawer ins Community Screen. On that file we also got:

```typescript
const MenuInterno = ({ navigation }: DrawerContentComponentProps) => {
return (
        <DrawerContentScrollView
            contentContainerStyle={{ flexGrow: 1, alignItems: 'center' }}
            style={{
                flexDirection: 'row',
            }}
        >
		<TouchableOpacity
			onPress={() => navigation.navigate('TermAndConditionsScreen')}
		>
		...
	</DrawerContentScrollView>
}
```

And this is how the navigation flows accross screens.

On the other hand, how do we use Redux? Inside MenuMain Drawer's props, there is `header: () => {return <Header />}` and if we go to Header, we got:

```typescript
export const Header = () => {
    const nickname = useAppSelector((state: RootState) => state.user.nickname);
	...
}
```

which gets the nickname from the store, since in Login we stated 

```typescript
async someFunc = () => {
	dispatch(
                    setUser({
                        nickname: alias,
                        notificationsNumber: n_notificaciones,
                        newChatMessagesNumber: n_chatmensajes,
                        universityId: id_universidad,
                        id: uid,
                    })
                );
	}
```

which went through the reducer named `user` created with `createSlice()`:

```typescript
export const userSlice = createSlice({
    name: 'user',
    initialState,
    reducers: {
        setUser: (state: UserState, action: PayloadAction<UserState>) => {
            state.nickname = action.payload.nickname;
            state.notificationsNumber = action.payload.notificationsNumber;
            state.newChatMessagesNumber = action.payload.newChatMessagesNumber;
            state.universityId = action.payload.universityId;
            state.id = action.payload.id;
        },
	...
    },
});
export const {
    setUser,
    ...
} = userSlice.actions;
export const selectUser = (state: RootState) => state.user;
```

