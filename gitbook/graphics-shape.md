# Shapes

## Introduction

SFML provides a set of classes that represent simple shape entities. Each type of shape is a separate class, but they all derive from the same base class so that they have access to the same subset of common features. Each class then adds its own specifics: a radius property for the circle class, a size for the rectangle class, points for the polygon class, etc. 

## Common shape properties

### Transformation (position, rotation, scale)

These properties are common to all the SFML graphical classes, so they are explained in a separate tutorial: [Transforming entities](./graphics-transform.html "'Transforming entities' tutorial"). 

### Color

One of the basic properties of a shape is its color. You can change with the `setFillColor` function. 

```
sf::CircleShape shape(50);

// set the shape color to green
shape.setFillColor(sf::Color(100, 250, 50));
```

![A colored shape](./images/graphics-shape-color.png)

### Outline

Shapes can have an outline. You can set the thickness and color of the outline with the `setOutlineThickness` and `setOutlineColor` functions. 

```
sf::CircleShape shape(50);
shape.setFillColor(sf::Color(150, 50, 250));

// set a 10-pixel wide orange outline
shape.setOutlineThickness(10);
shape.setOutlineColor(sf::Color(250, 150, 100));
```

![An outlined shape](./images/graphics-shape-outline.png)

By default, the outline is extruded outwards from the shape (e.g. if you have a circle with a radius of 10 and an outline thickness of 5, the total radius of the circle will be 15). You can make it extrude towards the center of the shape instead, by setting a negative thickness. 

To disable the outline, set its thickness to 0. If you only want the outline, you can set the fill color to `sf::Color::Transparent`. 

### Texture

Shapes can also be textured, just like sprites. To specify a part of the texture to be mapped to the shape, you must use the `setTextureRect` function. It takes the texture rectangle to map to the bounding rectangle of the shape. This method doesn't offer maximum flexibility, but it is much easier to use than individually setting the texture coordinates of each point of the shape. 

```
sf::CircleShape shape(50);

// map a 100x100 textured rectangle to the shape
shape.setTexture(&texture); // texture is a sf::Texture
shape.setTextureRect(sf::IntRect(10, 10, 100, 100));
```

![A textured shape](./images/graphics-shape-texture.png)

Note that the outline is not textured.  
It is important to know that the texture is modulated (multiplied) with the shape's fill color. If its fill color is sf::Color::White, the texture will appear unmodified.  
To disable texturing, call `setTexture(NULL)`. 

## Drawing a shape

Drawing a shape is as simple as drawing any other SFML entity: 

```
window.draw(shape);
```

## Built-in shape types

### Rectangles

To draw rectangles, you can use the [RectangleShape]({{book.api}}/RectangleShape.html) class. It has a single attribute: The size of the rectangle. 

```
// define a 120x50 rectangle
sf::RectangleShape rectangle(sf::Vector2f(120, 50));

// change the size to 100x100
rectangle.setSize(sf::Vector2f(100, 100));
```

![A rectangle shape](./images/graphics-shape-rectangle.png)

### Circles

Circles are represented by the [CircleShape]({{book.api}}/CircleShape.html) class. It has two attributes: The radius and the number of sides. The number of sides is an optional attribute, it allows you to adjust the "quality" of the circle: Circles have to be approximated by polygons with many sides (the graphics card is unable to draw a perfect circle directly), and this attribute defines how many sides your circle approximation will have. If you draw small circles, you'll probably only need a few sides. If you draw big circles, or zoom on regular circles, you'll most likely need more sides. 

```
// define a circle with radius = 200
sf::CircleShape circle(200);

// change the radius to 40
circle.setRadius(40);

// change the number of sides (points) to 100
circle.setPointCount(100);
```

![A circle shape](./images/graphics-shape-circle.png)

### Regular polygons

There's no dedicated class for regular polygons, in fact you can represent a regular polygon with any number of sides using the [CircleShape]({{book.api}}/CircleShape.html) class: Since circles are approximated by polygons with many sides, you just have to play with the number of sides to get the desired polygons. A [CircleShape]({{book.api}}/CircleShape.html) with 3 points is a triangle, with 4 points it's a square, etc. 

```
// define a triangle
sf::CircleShape triangle(80, 3);

// define a square
sf::CircleShape square(80, 4);

// define an octagon
sf::CircleShape octagon(80, 8);
```

![Regular polygons](./images/graphics-shape-regular.png)

### Convex shapes

The [ConvexShape]({{book.api}}/ConvexShape.html) class is the ultimate shape class: It allows you to define any *convex* shape. SFML is unable to draw concave shapes. If you need to draw a concave shape, you'll have to split it into multiple convex polygons. 

To construct a convex shape, you must first set the number of points it should have and then define the points. 

```
// create an empty shape
sf::ConvexShape convex;

// resize it to 5 points
convex.setPointCount(5);

// define the points
convex.setPoint(0, sf::Vector2f(0, 0));
convex.setPoint(1, sf::Vector2f(150, 10));
convex.setPoint(2, sf::Vector2f(120, 90));
convex.setPoint(3, sf::Vector2f(30, 100));
convex.setPoint(4, sf::Vector2f(0, 50));
```

The order in which you define the points is very important. They must *all* be defined either in clockwise or counter-clockwise order. If you define them in an inconsistent order, the shape will be constructed incorrectly. 

![A convex shape](./images/graphics-shape-convex.png)

Although the name of [ConvexShape]({{book.api}}/ConvexShape.html) implies that it should only be used to represent convex shapes, its requirements are a little more relaxed. In fact, the only requirement that your shape must meet is that if you went ahead and drew lines from its *center of gravity* to all of its points, these lines must be drawn in the same order. You are not allowed to "jump behind a previous line". Internally, convex shapes are automatically constructed using [triangle fans](http://en.wikipedia.org/wiki/Triangle_fan "Go to Wikipedia's article about triangle fans"), so if your shape is representable by a triangle fan, you can use [ConvexShape]({{book.api}}/ConvexShape.html). With this relaxed definition, you can draw stars using [ConvexShape]({{book.api}}/ConvexShape.html) for example. 

### Lines

There's no shape class for lines. The reason is simple: If your line has a thickness, it is a rectangle. If it doesn't, it can be drawn with a line primitive. 

Line with thickness: 

```
sf::RectangleShape line(sf::Vector2f(150, 5));
line.rotate(45);
```

![A line shape drawn as a rectangle](./images/graphics-shape-line-rectangle.png)

Line without thickness: 

```
sf::Vertex line[] =
{
    sf::Vertex(sf::Vector2f(10, 10)),
    sf::Vertex(sf::Vector2f(150, 150))
};

window.draw(line, 2, sf::Lines);
```

![A line shape drawn as a primitive](./images/graphics-shape-line-primitive.png)

To learn more about vertices and primitives, you can read the tutorial on [vertex arrays](./graphics-vertex-array.html "'Vertex arrays' tutorial"). 

## Custom shape types

You can extend the set of shape classes with your own shape types. To do so, you must derive from [Shape]({{book.api}}/Shape.html) and override two functions: 

  * `getPointCount`: return the number of points in the shape
  * `getPoint`: return a point of the shape

You must also call the `update()` protected function whenever any point in your shape changes, so that the base class is informed and can update its internal geometry. 

Here is a complete example of a custom shape class: EllipseShape. 

```
class EllipseShape : public sf::Shape
{
public :

    explicit EllipseShape(const sf::Vector2f& radius = sf::Vector2f(0, 0)) :
    m_radius(radius)
    {
        update();
    }

    void setRadius(const sf::Vector2f& radius)
    {
        m_radius = radius;
        update();
    }

    const sf::Vector2f& getRadius() const
    {
        return m_radius;
    }

    virtual unsigned int getPointCount() const
    {
        return 30; // fixed, but could be an attribute of the class if needed
    }

    virtual sf::Vector2f getPoint(unsigned int index) const
    {
        static const float pi = 3.141592654f;

        float angle = index * 2 * pi / getPointCount() - pi / 2;
        float x = std::cos(angle) * m_radius.x;
        float y = std::sin(angle) * m_radius.y;

        return sf::Vector2f(m_radius.x + x, m_radius.y + y);
    }

private :

    sf::Vector2f m_radius;
};
```

![An ellipse shape](./images/graphics-shape-ellipse.png)

## Antialiased shapes

There's no option to anti-alias a single shape. To get anti-aliased shapes (i.e. shapes with smoothed edges), you have to enable anti-aliasing globally when you create the window, with the corresponding attribute of the structure. 

```
sf::ContextSettings settings;
settings.antialiasingLevel = 8;

sf::RenderWindow window(sf::VideoMode(800, 600), "SFML shapes", sf::Style::Default, settings);
```

![Aliased vs antialiased shape](./images/graphics-shape-antialiasing.png)

Remember that anti-aliasing availability depends on the graphics card: It might not support it, or have it forced to disabled in the driver settings. 
