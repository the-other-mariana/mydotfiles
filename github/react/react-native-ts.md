# React Native with Typescript

## Hooks

- `useSelector()`: 
	
	- Allows you to extract data from the Redux store state, using a selector function. Will also subscribe to the Redux store, and run your selector whenever an action is dispatched.

	```ts
	const result: any = useSelector(selector: Function, equalityFn?: Function)
	```


## Typescript Utility Types

### <Partial<Type>>

Constructs a type with all properties of Type set to optional. Opposite of `<Required<Type>>`.

```ts
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

### <ReturnType<typeof func>>

This just sets the type to the return type of function `func`.

```ts
const func(a: number): number {
	return abs(a)
}

type absValue = <ReturnType<typeof func>>;
```

would be the same as:

```ts
type absValue = number; // option 1
type absValue = <ReturnType<() => string>; // option 2
```

## react-navigation or Stack Navigator

Stack Navigator provides a way for your app to transition between screens where each new screen is placed on top of a stack.

```ts
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

```ts
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

```ts
type RootStackParamList = {
  Home: undefined;
  Profile: { userId: string };
  Feed: { sort: 'latest' | 'top' } | undefined;
};
```

After we have defined the mappings, we need to tell our navigator to use it. To do that, we can pass it as a generic to the createXNavigator functions:

```ts
import { createStackNavigator } from '@react-navigation/stack';

const RootStack = createStackNavigator<RootStackParamList>();
```

### Screen

Screen components are used to configure various aspects of screens inside a navigator.A Screen is returned from a createXNavigator function:

```ts
const Stack = createNativeStackNavigator();
<Stack.Navigator>
  <Stack.Screen name="Home" component={HomeScreen} />
  <Stack.Screen name="Profile" component={ProfileScreen} />
</Stack.Navigator>
```
You need to provide at least a name and a component to render for each screen. The name string is used to navigate to that screen, and must coincide with the RootStackParamList attributes' names. The component prop is the React Component to render for the screen. All of the Stack.Screen components will be children of the Stack.Navigation component. By creating a Stack.Screen for Home route, it is the same as:

```ts
navigation.navigate('Home')}
```

### React Navigation Drawer

Common pattern in navigation is to use drawer from left (sometimes right) side for navigating between screens. It is the menu that unfolds from the left to the right in an app.

```ts
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

```
const state = navigationRef.getRootState();
```

## Interfaces + Objects

### Objects

### Interface

### Interface Example

- Inside a ToastMessage.tsx component we receive an object as props with type `Props`, and since we typed `{message, status}: Props`, by using {} we destructure the json object so that instead of having `props: Props` so that we use `props.message`, we now destructured the object there and have `message` directly.

```ts
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

```ts
<Provider store={store}>
        <Container />
</Provider>
```

- Container.tsx

```ts
<NavigationContainer>
	<Toast>
                <Navigator />
	</Toast>
</NavigationContainer>
```

- Navigator.tsx

```ts
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

```ts
<Drawer.Navigator>
	<Drawer.Screen name="CommunityScreen" component={CommunityScreen} />
	<Drawer.Screen name="MyIdeasScreen" component={MyIdeasScreen} />
        <Drawer.Screen name="TrackingScreen" component={TrackingScreen} />
        <Drawer.Screen name="SearchScreen" component={SearchScreen} />
</Drawer.Navigator>
```

- CreateIdeaScreen.tsx

```ts
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

```ts
const { form, onChange } = useForm({
        mensaje: '',
    	});

const { mensaje } = form;
```

that is importing useForm

```ts
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

```ts
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

