#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include <SFML/System.hpp>
using namespace sf;
extern "C" {
void sfml_blendmode_allocate(void** result) {
    *result = malloc(sizeof(BlendMode));
}
void sfml_blendmode_free(void* self) {
    free(self);
}
void sfml_blendmode_initialize(void* self) {
    new(self) BlendMode();
}
void sfml_blendmode_initialize_8xr8xrBw1(void* self, int source_factor, int destination_factor, int blend_equation) {
    new(self) BlendMode((BlendMode::Factor)source_factor, (BlendMode::Factor)destination_factor, (BlendMode::Equation)blend_equation);
}
void sfml_blendmode_initialize_8xr8xrBw18xr8xrBw1(void* self, int color_source_factor, int color_destination_factor, int color_blend_equation, int alpha_source_factor, int alpha_destination_factor, int alpha_blend_equation) {
    new(self) BlendMode((BlendMode::Factor)color_source_factor, (BlendMode::Factor)color_destination_factor, (BlendMode::Equation)color_blend_equation, (BlendMode::Factor)alpha_source_factor, (BlendMode::Factor)alpha_destination_factor, (BlendMode::Equation)alpha_blend_equation);
}
void sfml_blendmode_setcolorsrcfactor_8xr(void* self, int color_src_factor) {
    ((BlendMode*)self)->colorSrcFactor = (BlendMode::Factor)color_src_factor;
}
void sfml_blendmode_setcolordstfactor_8xr(void* self, int color_dst_factor) {
    ((BlendMode*)self)->colorDstFactor = (BlendMode::Factor)color_dst_factor;
}
void sfml_blendmode_setcolorequation_Bw1(void* self, int color_equation) {
    ((BlendMode*)self)->colorEquation = (BlendMode::Equation)color_equation;
}
void sfml_blendmode_setalphasrcfactor_8xr(void* self, int alpha_src_factor) {
    ((BlendMode*)self)->alphaSrcFactor = (BlendMode::Factor)alpha_src_factor;
}
void sfml_blendmode_setalphadstfactor_8xr(void* self, int alpha_dst_factor) {
    ((BlendMode*)self)->alphaDstFactor = (BlendMode::Factor)alpha_dst_factor;
}
void sfml_blendmode_setalphaequation_Bw1(void* self, int alpha_equation) {
    ((BlendMode*)self)->alphaEquation = (BlendMode::Equation)alpha_equation;
}
void sfml_operator_eq_PG5PG5(void* left, void* right, Int8* result) {
    *(bool*)result = operator==(*(BlendMode*)left, *(BlendMode*)right);
}
void sfml_operator_ne_PG5PG5(void* left, void* right, Int8* result) {
    *(bool*)result = operator!=(*(BlendMode*)left, *(BlendMode*)right);
}
void sfml_blendmode_initialize_PG5(void* self, void* copy) {
    new(self) BlendMode(*(BlendMode*)copy);
}
void sfml_transform_allocate(void** result) {
    *result = malloc(sizeof(Transform));
}
void sfml_transform_free(void* self) {
    free(self);
}
void sfml_transform_initialize(void* self) {
    new(self) Transform();
}
void sfml_transform_initialize_Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9(void* self, float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22) {
    new(self) Transform(a00, a01, a02, a10, a11, a12, a20, a21, a22);
}
void sfml_transform_getmatrix(void* self, float** result) {
    *(float**)result = const_cast<float*>(((Transform*)self)->getMatrix());
}
void sfml_transform_getinverse(void* self, void* result) {
    *(Transform*)result = ((Transform*)self)->getInverse();
}
void sfml_transform_transformpoint_Bw9Bw9(void* self, float x, float y, void* result) {
    *(Vector2f*)result = ((Transform*)self)->transformPoint(x, y);
}
void sfml_transform_transformpoint_UU2(void* self, void* point, void* result) {
    *(Vector2f*)result = ((Transform*)self)->transformPoint(*(Vector2f*)point);
}
void sfml_transform_transformrect_WPZ(void* self, void* rectangle, void* result) {
    *(FloatRect*)result = ((Transform*)self)->transformRect(*(FloatRect*)rectangle);
}
void sfml_transform_combine_FPe(void* self, void* transform, void* result) {
    *(Transform*)result = ((Transform*)self)->combine(*(Transform*)transform);
}
void sfml_transform_translate_Bw9Bw9(void* self, float x, float y, void* result) {
    *(Transform*)result = ((Transform*)self)->translate(x, y);
}
void sfml_transform_translate_UU2(void* self, void* offset, void* result) {
    *(Transform*)result = ((Transform*)self)->translate(*(Vector2f*)offset);
}
void sfml_transform_rotate_Bw9(void* self, float angle, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate(angle);
}
void sfml_transform_rotate_Bw9Bw9Bw9(void* self, float angle, float center_x, float center_y, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate(angle, center_x, center_y);
}
void sfml_transform_rotate_Bw9UU2(void* self, float angle, void* center, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate(angle, *(Vector2f*)center);
}
void sfml_transform_scale_Bw9Bw9(void* self, float scale_x, float scale_y, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(scale_x, scale_y);
}
void sfml_transform_scale_Bw9Bw9Bw9Bw9(void* self, float scale_x, float scale_y, float center_x, float center_y, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(scale_x, scale_y, center_x, center_y);
}
void sfml_transform_scale_UU2(void* self, void* factors, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(*(Vector2f*)factors);
}
void sfml_transform_scale_UU2UU2(void* self, void* factors, void* center, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(*(Vector2f*)factors, *(Vector2f*)center);
}
void sfml_operator_mul_FPeFPe(void* left, void* right, void* result) {
    *(Transform*)result = operator*(*(Transform*)left, *(Transform*)right);
}
void sfml_operator_mul_FPeUU2(void* left, void* right, void* result) {
    *(Vector2f*)result = operator*(*(Transform*)left, *(Vector2f*)right);
}
void sfml_operator_eq_FPeFPe(void* left, void* right, Int8* result) {
    *(bool*)result = operator==(*(Transform*)left, *(Transform*)right);
}
void sfml_operator_ne_FPeFPe(void* left, void* right, Int8* result) {
    *(bool*)result = operator!=(*(Transform*)left, *(Transform*)right);
}
void sfml_transform_initialize_FPe(void* self, void* copy) {
    new(self) Transform(*(Transform*)copy);
}
void sfml_renderstates_allocate(void** result) {
    *result = malloc(sizeof(RenderStates));
}
void sfml_renderstates_free(void* self) {
    free(self);
}
void sfml_renderstates_initialize(void* self) {
    new(self) RenderStates();
}
void sfml_renderstates_initialize_PG5(void* self, void* blend_mode) {
    new(self) RenderStates(*(BlendMode*)blend_mode);
}
void sfml_renderstates_initialize_FPe(void* self, void* transform) {
    new(self) RenderStates(*(Transform*)transform);
}
void sfml_renderstates_initialize_MXd(void* self, void* texture) {
    new(self) RenderStates((Texture*)texture);
}
void sfml_renderstates_initialize_8P6(void* self, void* shader) {
    new(self) RenderStates((Shader*)shader);
}
void sfml_renderstates_initialize_PG5FPeMXd8P6(void* self, void* blend_mode, void* transform, void* texture, void* shader) {
    new(self) RenderStates(*(BlendMode*)blend_mode, *(Transform*)transform, (Texture*)texture, (Shader*)shader);
}
void sfml_renderstates_setblendmode_CPE(void* self, void* blend_mode) {
    ((RenderStates*)self)->blendMode = *(BlendMode*)blend_mode;
}
void sfml_renderstates_settransform_lbe(void* self, void* transform) {
    ((RenderStates*)self)->transform = *(Transform*)transform;
}
void sfml_renderstates_settexture_MXd(void* self, void* texture) {
    ((RenderStates*)self)->texture = (Texture*)texture;
}
void sfml_renderstates_setshader_8P6(void* self, void* shader) {
    ((RenderStates*)self)->shader = (Shader*)shader;
}
void sfml_renderstates_initialize_mi4(void* self, void* copy) {
    new(self) RenderStates(*(RenderStates*)copy);
}
void sfml_drawable_allocate(void** result) {
    *result = malloc(sizeof(Drawable));
}
void sfml_drawable_free(void* self) {
    free(self);
}
void sfml_transformable_allocate(void** result) {
    *result = malloc(sizeof(Transformable));
}
void sfml_transformable_free(void* self) {
    free(self);
}
void sfml_transformable_initialize(void* self) {
    new(self) Transformable();
}
void sfml_transformable_finalize(void* self) {
    ((Transformable*)self)->~Transformable();
}
void sfml_transformable_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Transformable*)self)->setPosition(x, y);
}
void sfml_transformable_setposition_UU2(void* self, void* position) {
    ((Transformable*)self)->setPosition(*(Vector2f*)position);
}
void sfml_transformable_setrotation_Bw9(void* self, float angle) {
    ((Transformable*)self)->setRotation(angle);
}
void sfml_transformable_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Transformable*)self)->setScale(factor_x, factor_y);
}
void sfml_transformable_setscale_UU2(void* self, void* factors) {
    ((Transformable*)self)->setScale(*(Vector2f*)factors);
}
void sfml_transformable_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Transformable*)self)->setOrigin(x, y);
}
void sfml_transformable_setorigin_UU2(void* self, void* origin) {
    ((Transformable*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_transformable_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getPosition();
}
void sfml_transformable_getrotation(void* self, float* result) {
    *(float*)result = ((Transformable*)self)->getRotation();
}
void sfml_transformable_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getScale();
}
void sfml_transformable_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getOrigin();
}
void sfml_transformable_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Transformable*)self)->move(offset_x, offset_y);
}
void sfml_transformable_move_UU2(void* self, void* offset) {
    ((Transformable*)self)->move(*(Vector2f*)offset);
}
void sfml_transformable_rotate_Bw9(void* self, float angle) {
    ((Transformable*)self)->rotate(angle);
}
void sfml_transformable_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Transformable*)self)->scale(factor_x, factor_y);
}
void sfml_transformable_scale_UU2(void* self, void* factor) {
    ((Transformable*)self)->scale(*(Vector2f*)factor);
}
void sfml_transformable_gettransform(void* self, void* result) {
    *(Transform*)result = ((Transformable*)self)->getTransform();
}
void sfml_transformable_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Transformable*)self)->getInverseTransform();
}
void sfml_transformable_initialize_dkg(void* self, void* copy) {
    new(self) Transformable(*(Transformable*)copy);
}
void sfml_color_allocate(void** result) {
    *result = malloc(sizeof(Color));
}
void sfml_color_free(void* self) {
    free(self);
}
void sfml_color_initialize(void* self) {
    new(self) Color();
}
void sfml_color_initialize_9yU9yU9yU9yU(void* self, Uint8 red, Uint8 green, Uint8 blue, Uint8 alpha) {
    new(self) Color(red, green, blue, alpha);
}
void sfml_color_initialize_saL(void* self, Uint32 color) {
    new(self) Color(color);
}
void sfml_color_tointeger(void* self, Uint32* result) {
    *(Uint32*)result = ((Color*)self)->toInteger();
}
void sfml_color_setr_9yU(void* self, Uint8 r) {
    ((Color*)self)->r = r;
}
void sfml_color_setg_9yU(void* self, Uint8 g) {
    ((Color*)self)->g = g;
}
void sfml_color_setb_9yU(void* self, Uint8 b) {
    ((Color*)self)->b = b;
}
void sfml_color_seta_9yU(void* self, Uint8 a) {
    ((Color*)self)->a = a;
}
void sfml_operator_eq_QVeQVe(void* left, void* right, Int8* result) {
    *(bool*)result = operator==(*(Color*)left, *(Color*)right);
}
void sfml_operator_ne_QVeQVe(void* left, void* right, Int8* result) {
    *(bool*)result = operator!=(*(Color*)left, *(Color*)right);
}
void sfml_operator_add_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator+(*(Color*)left, *(Color*)right);
}
void sfml_operator_sub_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator-(*(Color*)left, *(Color*)right);
}
void sfml_operator_mul_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator*(*(Color*)left, *(Color*)right);
}
void sfml_color_initialize_QVe(void* self, void* copy) {
    new(self) Color(*(Color*)copy);
}
void sfml_vertex_allocate(void** result) {
    *result = malloc(sizeof(Vertex));
}
void sfml_vertex_free(void* self) {
    free(self);
}
void sfml_vertex_initialize(void* self) {
    new(self) Vertex();
}
void sfml_vertex_initialize_UU2(void* self, void* position) {
    new(self) Vertex(*(Vector2f*)position);
}
void sfml_vertex_initialize_UU2QVe(void* self, void* position, void* color) {
    new(self) Vertex(*(Vector2f*)position, *(Color*)color);
}
void sfml_vertex_initialize_UU2UU2(void* self, void* position, void* tex_coords) {
    new(self) Vertex(*(Vector2f*)position, *(Vector2f*)tex_coords);
}
void sfml_vertex_initialize_UU2QVeUU2(void* self, void* position, void* color, void* tex_coords) {
    new(self) Vertex(*(Vector2f*)position, *(Color*)color, *(Vector2f*)tex_coords);
}
void sfml_vertex_setposition_llt(void* self, void* position) {
    ((Vertex*)self)->position = *(Vector2f*)position;
}
void sfml_vertex_setcolor_9qU(void* self, void* color) {
    ((Vertex*)self)->color = *(Color*)color;
}
void sfml_vertex_settexcoords_llt(void* self, void* tex_coords) {
    ((Vertex*)self)->texCoords = *(Vector2f*)tex_coords;
}
void sfml_vertex_initialize_Y3J(void* self, void* copy) {
    new(self) Vertex(*(Vertex*)copy);
}
void sfml_vertexarray_allocate(void** result) {
    *result = malloc(sizeof(VertexArray));
}
void sfml_vertexarray_finalize(void* self) {
    ((VertexArray*)self)->~VertexArray();
}
void sfml_vertexarray_free(void* self) {
    free(self);
}
void sfml_vertexarray_initialize(void* self) {
    new(self) VertexArray();
}
void sfml_vertexarray_initialize_u9wvgv(void* self, int type, std::size_t vertex_count) {
    new(self) VertexArray((PrimitiveType)type, vertex_count);
}
void sfml_vertexarray_getvertexcount(void* self, std::size_t* result) {
    *(std::size_t*)result = ((VertexArray*)self)->getVertexCount();
}
void sfml_vertexarray_operator_indexset_vgvRos(void* self, std::size_t index, void* value) {
    ((VertexArray*)self)->operator[](index) = *(Vertex*)value;
}
void sfml_vertexarray_operator_index_vgv(void* self, std::size_t index, void* result) {
    *(Vertex*)result = ((VertexArray*)self)->operator[](index);
}
void sfml_vertexarray_clear(void* self) {
    ((VertexArray*)self)->clear();
}
void sfml_vertexarray_resize_vgv(void* self, std::size_t vertex_count) {
    ((VertexArray*)self)->resize(vertex_count);
}
void sfml_vertexarray_append_Y3J(void* self, void* vertex) {
    ((VertexArray*)self)->append(*(Vertex*)vertex);
}
void sfml_vertexarray_setprimitivetype_u9w(void* self, int type) {
    ((VertexArray*)self)->setPrimitiveType((PrimitiveType)type);
}
void sfml_vertexarray_getprimitivetype(void* self, int* result) {
    *(PrimitiveType*)result = ((VertexArray*)self)->getPrimitiveType();
}
void sfml_vertexarray_getbounds(void* self, void* result) {
    *(FloatRect*)result = ((VertexArray*)self)->getBounds();
}
void sfml_vertexarray_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void sfml_vertexarray_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void sfml_vertexarray_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void sfml_vertexarray_initialize_EXB(void* self, void* copy) {
    new(self) VertexArray(*(VertexArray*)copy);
}
void (*_sfml_shape_getpointcount_callback)(void*, std::size_t*) = 0;
void sfml_shape_getpointcount_callback(void (*callback)(void*, std::size_t*)) {
    _sfml_shape_getpointcount_callback = callback;
}
void (*_sfml_shape_getpoint_callback)(void*, std::size_t, void*) = 0;
void sfml_shape_getpoint_callback(void (*callback)(void*, std::size_t, void*)) {
    _sfml_shape_getpoint_callback = callback;
}
class _Shape : public sf::Shape {
public:
    void* parent;
    virtual std::size_t getPointCount() const {
        std::size_t result;
        _sfml_shape_getpointcount_callback(parent, (std::size_t*)&result);
        return result;
    }
    virtual Vector2f getPoint(std::size_t index) const {
        Vector2f result;
        _sfml_shape_getpoint_callback(parent, (std::size_t)index, &result);
        return result;
    }
    using Shape::update;
};
void sfml_shape_parent(void* self, void* parent) {
    ((_Shape*)self)->parent = parent;
}
void sfml_shape_allocate(void** result) {
    *result = malloc(sizeof(_Shape));
}
void sfml_shape_free(void* self) {
    free(self);
}
void sfml_shape_finalize(void* self) {
    ((_Shape*)self)->~_Shape();
}
void sfml_shape_settexture_MXdGZq(void* self, void* texture, Int8 reset_rect) {
    ((_Shape*)self)->setTexture((Texture*)texture, reset_rect != 0);
}
void sfml_shape_settexturerect_2k1(void* self, void* rect) {
    ((_Shape*)self)->setTextureRect(*(IntRect*)rect);
}
void sfml_shape_setfillcolor_QVe(void* self, void* color) {
    ((_Shape*)self)->setFillColor(*(Color*)color);
}
void sfml_shape_setoutlinecolor_QVe(void* self, void* color) {
    ((_Shape*)self)->setOutlineColor(*(Color*)color);
}
void sfml_shape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((_Shape*)self)->setOutlineThickness(thickness);
}
void sfml_shape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((_Shape*)self)->getTexture());
}
void sfml_shape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((_Shape*)self)->getTextureRect();
}
void sfml_shape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((_Shape*)self)->getFillColor();
}
void sfml_shape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((_Shape*)self)->getOutlineColor();
}
void sfml_shape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((_Shape*)self)->getOutlineThickness();
}
void sfml_shape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((_Shape*)self)->getLocalBounds();
}
void sfml_shape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((_Shape*)self)->getGlobalBounds();
}
void sfml_shape_initialize(void* self) {
    new(self) _Shape();
}
void sfml_shape_update(void* self) {
    ((_Shape*)self)->update();
}
void sfml_shape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((_Shape*)self)->setPosition(x, y);
}
void sfml_shape_setposition_UU2(void* self, void* position) {
    ((_Shape*)self)->setPosition(*(Vector2f*)position);
}
void sfml_shape_setrotation_Bw9(void* self, float angle) {
    ((_Shape*)self)->setRotation(angle);
}
void sfml_shape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((_Shape*)self)->setScale(factor_x, factor_y);
}
void sfml_shape_setscale_UU2(void* self, void* factors) {
    ((_Shape*)self)->setScale(*(Vector2f*)factors);
}
void sfml_shape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((_Shape*)self)->setOrigin(x, y);
}
void sfml_shape_setorigin_UU2(void* self, void* origin) {
    ((_Shape*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_shape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getPosition();
}
void sfml_shape_getrotation(void* self, float* result) {
    *(float*)result = ((_Shape*)self)->getRotation();
}
void sfml_shape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getScale();
}
void sfml_shape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getOrigin();
}
void sfml_shape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((_Shape*)self)->move(offset_x, offset_y);
}
void sfml_shape_move_UU2(void* self, void* offset) {
    ((_Shape*)self)->move(*(Vector2f*)offset);
}
void sfml_shape_rotate_Bw9(void* self, float angle) {
    ((_Shape*)self)->rotate(angle);
}
void sfml_shape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((_Shape*)self)->scale(factor_x, factor_y);
}
void sfml_shape_scale_UU2(void* self, void* factor) {
    ((_Shape*)self)->scale(*(Vector2f*)factor);
}
void sfml_shape_gettransform(void* self, void* result) {
    *(Transform*)result = ((_Shape*)self)->getTransform();
}
void sfml_shape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((_Shape*)self)->getInverseTransform();
}
void sfml_shape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void sfml_shape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void sfml_shape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void sfml_circleshape_allocate(void** result) {
    *result = malloc(sizeof(CircleShape));
}
void sfml_circleshape_finalize(void* self) {
    ((CircleShape*)self)->~CircleShape();
}
void sfml_circleshape_free(void* self) {
    free(self);
}
void sfml_circleshape_initialize_Bw9vgv(void* self, float radius, std::size_t point_count) {
    new(self) CircleShape(radius, point_count);
}
void sfml_circleshape_setradius_Bw9(void* self, float radius) {
    ((CircleShape*)self)->setRadius(radius);
}
void sfml_circleshape_getradius(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getRadius();
}
void sfml_circleshape_setpointcount_vgv(void* self, std::size_t count) {
    ((CircleShape*)self)->setPointCount(count);
}
void sfml_circleshape_getpointcount(void* self, std::size_t* result) {
    *(std::size_t*)result = ((CircleShape*)self)->getPointCount();
}
void sfml_circleshape_getpoint_vgv(void* self, std::size_t index, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getPoint(index);
}
void sfml_circleshape_settexture_MXdGZq(void* self, void* texture, Int8 reset_rect) {
    ((CircleShape*)self)->setTexture((Texture*)texture, reset_rect != 0);
}
void sfml_circleshape_settexturerect_2k1(void* self, void* rect) {
    ((CircleShape*)self)->setTextureRect(*(IntRect*)rect);
}
void sfml_circleshape_setfillcolor_QVe(void* self, void* color) {
    ((CircleShape*)self)->setFillColor(*(Color*)color);
}
void sfml_circleshape_setoutlinecolor_QVe(void* self, void* color) {
    ((CircleShape*)self)->setOutlineColor(*(Color*)color);
}
void sfml_circleshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((CircleShape*)self)->setOutlineThickness(thickness);
}
void sfml_circleshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((CircleShape*)self)->getTexture());
}
void sfml_circleshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((CircleShape*)self)->getTextureRect();
}
void sfml_circleshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((CircleShape*)self)->getFillColor();
}
void sfml_circleshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((CircleShape*)self)->getOutlineColor();
}
void sfml_circleshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getOutlineThickness();
}
void sfml_circleshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((CircleShape*)self)->getLocalBounds();
}
void sfml_circleshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((CircleShape*)self)->getGlobalBounds();
}
void sfml_circleshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((CircleShape*)self)->setPosition(x, y);
}
void sfml_circleshape_setposition_UU2(void* self, void* position) {
    ((CircleShape*)self)->setPosition(*(Vector2f*)position);
}
void sfml_circleshape_setrotation_Bw9(void* self, float angle) {
    ((CircleShape*)self)->setRotation(angle);
}
void sfml_circleshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((CircleShape*)self)->setScale(factor_x, factor_y);
}
void sfml_circleshape_setscale_UU2(void* self, void* factors) {
    ((CircleShape*)self)->setScale(*(Vector2f*)factors);
}
void sfml_circleshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((CircleShape*)self)->setOrigin(x, y);
}
void sfml_circleshape_setorigin_UU2(void* self, void* origin) {
    ((CircleShape*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_circleshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getPosition();
}
void sfml_circleshape_getrotation(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getRotation();
}
void sfml_circleshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getScale();
}
void sfml_circleshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getOrigin();
}
void sfml_circleshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((CircleShape*)self)->move(offset_x, offset_y);
}
void sfml_circleshape_move_UU2(void* self, void* offset) {
    ((CircleShape*)self)->move(*(Vector2f*)offset);
}
void sfml_circleshape_rotate_Bw9(void* self, float angle) {
    ((CircleShape*)self)->rotate(angle);
}
void sfml_circleshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((CircleShape*)self)->scale(factor_x, factor_y);
}
void sfml_circleshape_scale_UU2(void* self, void* factor) {
    ((CircleShape*)self)->scale(*(Vector2f*)factor);
}
void sfml_circleshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((CircleShape*)self)->getTransform();
}
void sfml_circleshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((CircleShape*)self)->getInverseTransform();
}
void sfml_circleshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void sfml_circleshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void sfml_circleshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void sfml_circleshape_initialize_Ii7(void* self, void* copy) {
    new(self) CircleShape(*(CircleShape*)copy);
}
void sfml_convexshape_allocate(void** result) {
    *result = malloc(sizeof(ConvexShape));
}
void sfml_convexshape_finalize(void* self) {
    ((ConvexShape*)self)->~ConvexShape();
}
void sfml_convexshape_free(void* self) {
    free(self);
}
void sfml_convexshape_initialize_vgv(void* self, std::size_t point_count) {
    new(self) ConvexShape(point_count);
}
void sfml_convexshape_setpointcount_vgv(void* self, std::size_t count) {
    ((ConvexShape*)self)->setPointCount(count);
}
void sfml_convexshape_getpointcount(void* self, std::size_t* result) {
    *(std::size_t*)result = ((ConvexShape*)self)->getPointCount();
}
void sfml_convexshape_setpoint_vgvUU2(void* self, std::size_t index, void* point) {
    ((ConvexShape*)self)->setPoint(index, *(Vector2f*)point);
}
void sfml_convexshape_getpoint_vgv(void* self, std::size_t index, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getPoint(index);
}
void sfml_convexshape_settexture_MXdGZq(void* self, void* texture, Int8 reset_rect) {
    ((ConvexShape*)self)->setTexture((Texture*)texture, reset_rect != 0);
}
void sfml_convexshape_settexturerect_2k1(void* self, void* rect) {
    ((ConvexShape*)self)->setTextureRect(*(IntRect*)rect);
}
void sfml_convexshape_setfillcolor_QVe(void* self, void* color) {
    ((ConvexShape*)self)->setFillColor(*(Color*)color);
}
void sfml_convexshape_setoutlinecolor_QVe(void* self, void* color) {
    ((ConvexShape*)self)->setOutlineColor(*(Color*)color);
}
void sfml_convexshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((ConvexShape*)self)->setOutlineThickness(thickness);
}
void sfml_convexshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((ConvexShape*)self)->getTexture());
}
void sfml_convexshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((ConvexShape*)self)->getTextureRect();
}
void sfml_convexshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((ConvexShape*)self)->getFillColor();
}
void sfml_convexshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((ConvexShape*)self)->getOutlineColor();
}
void sfml_convexshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((ConvexShape*)self)->getOutlineThickness();
}
void sfml_convexshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((ConvexShape*)self)->getLocalBounds();
}
void sfml_convexshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((ConvexShape*)self)->getGlobalBounds();
}
void sfml_convexshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((ConvexShape*)self)->setPosition(x, y);
}
void sfml_convexshape_setposition_UU2(void* self, void* position) {
    ((ConvexShape*)self)->setPosition(*(Vector2f*)position);
}
void sfml_convexshape_setrotation_Bw9(void* self, float angle) {
    ((ConvexShape*)self)->setRotation(angle);
}
void sfml_convexshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((ConvexShape*)self)->setScale(factor_x, factor_y);
}
void sfml_convexshape_setscale_UU2(void* self, void* factors) {
    ((ConvexShape*)self)->setScale(*(Vector2f*)factors);
}
void sfml_convexshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((ConvexShape*)self)->setOrigin(x, y);
}
void sfml_convexshape_setorigin_UU2(void* self, void* origin) {
    ((ConvexShape*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_convexshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getPosition();
}
void sfml_convexshape_getrotation(void* self, float* result) {
    *(float*)result = ((ConvexShape*)self)->getRotation();
}
void sfml_convexshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getScale();
}
void sfml_convexshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getOrigin();
}
void sfml_convexshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((ConvexShape*)self)->move(offset_x, offset_y);
}
void sfml_convexshape_move_UU2(void* self, void* offset) {
    ((ConvexShape*)self)->move(*(Vector2f*)offset);
}
void sfml_convexshape_rotate_Bw9(void* self, float angle) {
    ((ConvexShape*)self)->rotate(angle);
}
void sfml_convexshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((ConvexShape*)self)->scale(factor_x, factor_y);
}
void sfml_convexshape_scale_UU2(void* self, void* factor) {
    ((ConvexShape*)self)->scale(*(Vector2f*)factor);
}
void sfml_convexshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((ConvexShape*)self)->getTransform();
}
void sfml_convexshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((ConvexShape*)self)->getInverseTransform();
}
void sfml_convexshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void sfml_convexshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void sfml_convexshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void sfml_convexshape_initialize_Ydx(void* self, void* copy) {
    new(self) ConvexShape(*(ConvexShape*)copy);
}
void sfml_glyph_allocate(void** result) {
    *result = malloc(sizeof(Glyph));
}
void sfml_glyph_free(void* self) {
    free(self);
}
void sfml_glyph_initialize(void* self) {
    new(self) Glyph();
}
void sfml_glyph_setadvance_Bw9(void* self, float advance) {
    ((Glyph*)self)->advance = advance;
}
void sfml_glyph_setbounds_5MC(void* self, void* bounds) {
    ((Glyph*)self)->bounds = *(FloatRect*)bounds;
}
void sfml_glyph_settexturerect_POq(void* self, void* texture_rect) {
    ((Glyph*)self)->textureRect = *(IntRect*)texture_rect;
}
void sfml_glyph_initialize_UlF(void* self, void* copy) {
    new(self) Glyph(*(Glyph*)copy);
}
void sfml_image_allocate(void** result) {
    *result = malloc(sizeof(Image));
}
void sfml_image_free(void* self) {
    free(self);
}
void sfml_image_initialize(void* self) {
    new(self) Image();
}
void sfml_image_finalize(void* self) {
    ((Image*)self)->~Image();
}
void sfml_image_create_emSemSQVe(void* self, unsigned int width, unsigned int height, void* color) {
    ((Image*)self)->create(width, height, *(Color*)color);
}
void sfml_image_create_emSemS843(void* self, unsigned int width, unsigned int height, Uint8* pixels) {
    ((Image*)self)->create(width, height, pixels);
}
void sfml_image_loadfromfile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((Image*)self)->loadFromFile(std::string(filename, filename_size));
}
void sfml_image_loadfrommemory_5h8vgv(void* self, void* data, std::size_t size, Int8* result) {
    *(bool*)result = ((Image*)self)->loadFromMemory(data, size);
}
void sfml_image_loadfromstream_PO0(void* self, void* stream, Int8* result) {
    *(bool*)result = ((Image*)self)->loadFromStream(*(InputStream*)stream);
}
void sfml_image_savetofile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((Image*)self)->saveToFile(std::string(filename, filename_size));
}
void sfml_image_getsize(void* self, void* result) {
    *(Vector2u*)result = ((Image*)self)->getSize();
}
void sfml_image_createmaskfromcolor_QVe9yU(void* self, void* color, Uint8 alpha) {
    ((Image*)self)->createMaskFromColor(*(Color*)color, alpha);
}
void sfml_image_copy_dptemSemS2k1GZq(void* self, void* source, unsigned int dest_x, unsigned int dest_y, void* source_rect, Int8 apply_alpha) {
    ((Image*)self)->copy(*(Image*)source, dest_x, dest_y, *(IntRect*)source_rect, apply_alpha != 0);
}
void sfml_image_setpixel_emSemSQVe(void* self, unsigned int x, unsigned int y, void* color) {
    ((Image*)self)->setPixel(x, y, *(Color*)color);
}
void sfml_image_getpixel_emSemS(void* self, unsigned int x, unsigned int y, void* result) {
    *(Color*)result = ((Image*)self)->getPixel(x, y);
}
void sfml_image_getpixelsptr(void* self, Uint8** result) {
    *(Uint8**)result = const_cast<Uint8*>(((Image*)self)->getPixelsPtr());
}
void sfml_image_fliphorizontally(void* self) {
    ((Image*)self)->flipHorizontally();
}
void sfml_image_flipvertically(void* self) {
    ((Image*)self)->flipVertically();
}
void sfml_image_initialize_dpt(void* self, void* copy) {
    new(self) Image(*(Image*)copy);
}
void sfml_texture_allocate(void** result) {
    *result = malloc(sizeof(Texture));
}
void sfml_texture_free(void* self) {
    free(self);
}
void sfml_texture_initialize(void* self) {
    new(self) Texture();
}
void sfml_texture_finalize(void* self) {
    ((Texture*)self)->~Texture();
}
void sfml_texture_create_emSemS(void* self, unsigned int width, unsigned int height, Int8* result) {
    *(bool*)result = ((Texture*)self)->create(width, height);
}
void sfml_texture_loadfromfile_zkC2k1(void* self, std::size_t filename_size, char* filename, void* area, Int8* result) {
    *(bool*)result = ((Texture*)self)->loadFromFile(std::string(filename, filename_size), *(IntRect*)area);
}
void sfml_texture_loadfrommemory_5h8vgv2k1(void* self, void* data, std::size_t size, void* area, Int8* result) {
    *(bool*)result = ((Texture*)self)->loadFromMemory(data, size, *(IntRect*)area);
}
void sfml_texture_loadfromstream_PO02k1(void* self, void* stream, void* area, Int8* result) {
    *(bool*)result = ((Texture*)self)->loadFromStream(*(InputStream*)stream, *(IntRect*)area);
}
void sfml_texture_loadfromimage_dpt2k1(void* self, void* image, void* area, Int8* result) {
    *(bool*)result = ((Texture*)self)->loadFromImage(*(Image*)image, *(IntRect*)area);
}
void sfml_texture_getsize(void* self, void* result) {
    *(Vector2u*)result = ((Texture*)self)->getSize();
}
void sfml_texture_copytoimage(void* self, void* result) {
    *(Image*)result = ((Texture*)self)->copyToImage();
}
void sfml_texture_update_843(void* self, Uint8* pixels) {
    ((Texture*)self)->update(pixels);
}
void sfml_texture_update_843emSemSemSemS(void* self, Uint8* pixels, unsigned int width, unsigned int height, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(pixels, width, height, x, y);
}
void sfml_texture_update_DJb(void* self, void* texture) {
    ((Texture*)self)->update(*(Texture*)texture);
}
void sfml_texture_update_DJbemSemS(void* self, void* texture, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(*(Texture*)texture, x, y);
}
void sfml_texture_update_dpt(void* self, void* image) {
    ((Texture*)self)->update(*(Image*)image);
}
void sfml_texture_update_dptemSemS(void* self, void* image, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(*(Image*)image, x, y);
}
void sfml_texture_update_JRh(void* self, void* window) {
    ((Texture*)self)->update(*(Window*)window);
}
void sfml_texture_update_JRhemSemS(void* self, void* window, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(*(Window*)window, x, y);
}
void sfml_texture_setsmooth_GZq(void* self, Int8 smooth) {
    ((Texture*)self)->setSmooth(smooth != 0);
}
void sfml_texture_issmooth(void* self, Int8* result) {
    *(bool*)result = ((Texture*)self)->isSmooth();
}
void sfml_texture_setsrgb_GZq(void* self, Int8 s_rgb) {
    ((Texture*)self)->setSrgb(s_rgb != 0);
}
void sfml_texture_issrgb(void* self, Int8* result) {
    *(bool*)result = ((Texture*)self)->isSrgb();
}
void sfml_texture_setrepeated_GZq(void* self, Int8 repeated) {
    ((Texture*)self)->setRepeated(repeated != 0);
}
void sfml_texture_isrepeated(void* self, Int8* result) {
    *(bool*)result = ((Texture*)self)->isRepeated();
}
void sfml_texture_generatemipmap(void* self, Int8* result) {
    *(bool*)result = ((Texture*)self)->generateMipmap();
}
void sfml_texture_swap_zUT(void* self, void* right) {
    ((Texture*)self)->swap(*(Texture*)right);
}
void sfml_texture_getnativehandle(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Texture*)self)->getNativeHandle();
}
void sfml_texture_bind_MXdK9j(void* texture, int coordinate_type) {
    Texture::bind((Texture*)texture, (Texture::CoordinateType)coordinate_type);
}
void sfml_texture_getmaximumsize(unsigned int* result) {
    *(unsigned int*)result = Texture::getMaximumSize();
}
void sfml_texture_initialize_DJb(void* self, void* copy) {
    new(self) Texture(*(Texture*)copy);
}
void sfml_font_allocate(void** result) {
    *result = malloc(sizeof(Font));
}
void sfml_font_free(void* self) {
    free(self);
}
void sfml_font_info_allocate(void** result) {
    *result = malloc(sizeof(Font::Info));
}
void sfml_font_info_initialize(void* self) {
    new(self) Font::Info();
}
void sfml_font_info_finalize(void* self) {
    ((Font::Info*)self)->~Info();
}
void sfml_font_info_free(void* self) {
    free(self);
}
void sfml_font_info_getfamily(void* self, char** result) {
    static std::string str;
    str = ((Font::Info*)self)->family;
    *result = const_cast<char*>(str.c_str());
}
void sfml_font_info_setfamily_Fzm(void* self, std::size_t family_size, char* family) {
    ((Font::Info*)self)->family = std::string(family, family_size);
}
void sfml_font_info_initialize_HPc(void* self, void* copy) {
    new(self) Font::Info(*(Font::Info*)copy);
}
void sfml_font_initialize(void* self) {
    new(self) Font();
}
void sfml_font_finalize(void* self) {
    ((Font*)self)->~Font();
}
void sfml_font_loadfromfile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((Font*)self)->loadFromFile(std::string(filename, filename_size));
}
void sfml_font_loadfrommemory_5h8vgv(void* self, void* data, std::size_t size_in_bytes, Int8* result) {
    *(bool*)result = ((Font*)self)->loadFromMemory(data, size_in_bytes);
}
void sfml_font_loadfromstream_PO0(void* self, void* stream, Int8* result) {
    *(bool*)result = ((Font*)self)->loadFromStream(*(InputStream*)stream);
}
void sfml_font_getinfo(void* self, void** result) {
    *(Font::Info**)result = const_cast<Font::Info*>(&((Font*)self)->getInfo());
}
void sfml_font_getglyph_saLemSGZqBw9(void* self, Uint32 code_point, unsigned int character_size, Int8 bold, float outline_thickness, void* result) {
    *(Glyph*)result = ((Font*)self)->getGlyph(code_point, character_size, bold != 0, outline_thickness);
}
void sfml_font_getkerning_saLsaLemS(void* self, Uint32 first, Uint32 second, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getKerning(first, second, character_size);
}
void sfml_font_getlinespacing_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getLineSpacing(character_size);
}
void sfml_font_getunderlineposition_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getUnderlinePosition(character_size);
}
void sfml_font_getunderlinethickness_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getUnderlineThickness(character_size);
}
void sfml_font_gettexture_emS(void* self, unsigned int character_size, void** result) {
    *(Texture**)result = const_cast<Texture*>(&((Font*)self)->getTexture(character_size));
}
void sfml_font_initialize_7CF(void* self, void* copy) {
    new(self) Font(*(Font*)copy);
}
void sfml_rectangleshape_allocate(void** result) {
    *result = malloc(sizeof(RectangleShape));
}
void sfml_rectangleshape_finalize(void* self) {
    ((RectangleShape*)self)->~RectangleShape();
}
void sfml_rectangleshape_free(void* self) {
    free(self);
}
void sfml_rectangleshape_initialize_UU2(void* self, void* size) {
    new(self) RectangleShape(*(Vector2f*)size);
}
void sfml_rectangleshape_setsize_UU2(void* self, void* size) {
    ((RectangleShape*)self)->setSize(*(Vector2f*)size);
}
void sfml_rectangleshape_getsize(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getSize();
}
void sfml_rectangleshape_getpointcount(void* self, std::size_t* result) {
    *(std::size_t*)result = ((RectangleShape*)self)->getPointCount();
}
void sfml_rectangleshape_getpoint_vgv(void* self, std::size_t index, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getPoint(index);
}
void sfml_rectangleshape_settexture_MXdGZq(void* self, void* texture, Int8 reset_rect) {
    ((RectangleShape*)self)->setTexture((Texture*)texture, reset_rect != 0);
}
void sfml_rectangleshape_settexturerect_2k1(void* self, void* rect) {
    ((RectangleShape*)self)->setTextureRect(*(IntRect*)rect);
}
void sfml_rectangleshape_setfillcolor_QVe(void* self, void* color) {
    ((RectangleShape*)self)->setFillColor(*(Color*)color);
}
void sfml_rectangleshape_setoutlinecolor_QVe(void* self, void* color) {
    ((RectangleShape*)self)->setOutlineColor(*(Color*)color);
}
void sfml_rectangleshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((RectangleShape*)self)->setOutlineThickness(thickness);
}
void sfml_rectangleshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((RectangleShape*)self)->getTexture());
}
void sfml_rectangleshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((RectangleShape*)self)->getTextureRect();
}
void sfml_rectangleshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((RectangleShape*)self)->getFillColor();
}
void sfml_rectangleshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((RectangleShape*)self)->getOutlineColor();
}
void sfml_rectangleshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((RectangleShape*)self)->getOutlineThickness();
}
void sfml_rectangleshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((RectangleShape*)self)->getLocalBounds();
}
void sfml_rectangleshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((RectangleShape*)self)->getGlobalBounds();
}
void sfml_rectangleshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((RectangleShape*)self)->setPosition(x, y);
}
void sfml_rectangleshape_setposition_UU2(void* self, void* position) {
    ((RectangleShape*)self)->setPosition(*(Vector2f*)position);
}
void sfml_rectangleshape_setrotation_Bw9(void* self, float angle) {
    ((RectangleShape*)self)->setRotation(angle);
}
void sfml_rectangleshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((RectangleShape*)self)->setScale(factor_x, factor_y);
}
void sfml_rectangleshape_setscale_UU2(void* self, void* factors) {
    ((RectangleShape*)self)->setScale(*(Vector2f*)factors);
}
void sfml_rectangleshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((RectangleShape*)self)->setOrigin(x, y);
}
void sfml_rectangleshape_setorigin_UU2(void* self, void* origin) {
    ((RectangleShape*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_rectangleshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getPosition();
}
void sfml_rectangleshape_getrotation(void* self, float* result) {
    *(float*)result = ((RectangleShape*)self)->getRotation();
}
void sfml_rectangleshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getScale();
}
void sfml_rectangleshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getOrigin();
}
void sfml_rectangleshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((RectangleShape*)self)->move(offset_x, offset_y);
}
void sfml_rectangleshape_move_UU2(void* self, void* offset) {
    ((RectangleShape*)self)->move(*(Vector2f*)offset);
}
void sfml_rectangleshape_rotate_Bw9(void* self, float angle) {
    ((RectangleShape*)self)->rotate(angle);
}
void sfml_rectangleshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((RectangleShape*)self)->scale(factor_x, factor_y);
}
void sfml_rectangleshape_scale_UU2(void* self, void* factor) {
    ((RectangleShape*)self)->scale(*(Vector2f*)factor);
}
void sfml_rectangleshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((RectangleShape*)self)->getTransform();
}
void sfml_rectangleshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((RectangleShape*)self)->getInverseTransform();
}
void sfml_rectangleshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void sfml_rectangleshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void sfml_rectangleshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void sfml_rectangleshape_initialize_wlj(void* self, void* copy) {
    new(self) RectangleShape(*(RectangleShape*)copy);
}
void sfml_view_allocate(void** result) {
    *result = malloc(sizeof(View));
}
void sfml_view_finalize(void* self) {
    ((View*)self)->~View();
}
void sfml_view_free(void* self) {
    free(self);
}
void sfml_view_initialize(void* self) {
    new(self) View();
}
void sfml_view_initialize_WPZ(void* self, void* rectangle) {
    new(self) View(*(FloatRect*)rectangle);
}
void sfml_view_initialize_UU2UU2(void* self, void* center, void* size) {
    new(self) View(*(Vector2f*)center, *(Vector2f*)size);
}
void sfml_view_setcenter_Bw9Bw9(void* self, float x, float y) {
    ((View*)self)->setCenter(x, y);
}
void sfml_view_setcenter_UU2(void* self, void* center) {
    ((View*)self)->setCenter(*(Vector2f*)center);
}
void sfml_view_setsize_Bw9Bw9(void* self, float width, float height) {
    ((View*)self)->setSize(width, height);
}
void sfml_view_setsize_UU2(void* self, void* size) {
    ((View*)self)->setSize(*(Vector2f*)size);
}
void sfml_view_setrotation_Bw9(void* self, float angle) {
    ((View*)self)->setRotation(angle);
}
void sfml_view_setviewport_WPZ(void* self, void* viewport) {
    ((View*)self)->setViewport(*(FloatRect*)viewport);
}
void sfml_view_reset_WPZ(void* self, void* rectangle) {
    ((View*)self)->reset(*(FloatRect*)rectangle);
}
void sfml_view_getcenter(void* self, void* result) {
    *(Vector2f*)result = ((View*)self)->getCenter();
}
void sfml_view_getsize(void* self, void* result) {
    *(Vector2f*)result = ((View*)self)->getSize();
}
void sfml_view_getrotation(void* self, float* result) {
    *(float*)result = ((View*)self)->getRotation();
}
void sfml_view_getviewport(void* self, void* result) {
    *(FloatRect*)result = ((View*)self)->getViewport();
}
void sfml_view_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((View*)self)->move(offset_x, offset_y);
}
void sfml_view_move_UU2(void* self, void* offset) {
    ((View*)self)->move(*(Vector2f*)offset);
}
void sfml_view_rotate_Bw9(void* self, float angle) {
    ((View*)self)->rotate(angle);
}
void sfml_view_zoom_Bw9(void* self, float factor) {
    ((View*)self)->zoom(factor);
}
void sfml_view_gettransform(void* self, void* result) {
    *(Transform*)result = ((View*)self)->getTransform();
}
void sfml_view_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((View*)self)->getInverseTransform();
}
void sfml_view_initialize_DDi(void* self, void* copy) {
    new(self) View(*(View*)copy);
}
void sfml_rendertarget_allocate(void** result) {
    *result = malloc(sizeof(RenderTarget));
}
void sfml_rendertarget_free(void* self) {
    free(self);
}
void sfml_rendertarget_clear_QVe(void* self, void* color) {
    ((RenderTarget*)self)->clear(*(Color*)color);
}
void sfml_rendertarget_setview_DDi(void* self, void* view) {
    ((RenderTarget*)self)->setView(*(View*)view);
}
void sfml_rendertarget_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTarget*)self)->getView());
}
void sfml_rendertarget_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTarget*)self)->getDefaultView());
}
void sfml_rendertarget_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderTarget*)self)->getViewport(*(View*)view);
}
void sfml_rendertarget_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderTarget*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void sfml_rendertarget_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderTarget*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void sfml_rendertarget_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderTarget*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void sfml_rendertarget_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderTarget*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void sfml_rendertarget_draw_46svgvu9wmi4(void* self, void* vertices, std::size_t vertex_count, int type, void* states) {
    ((RenderTarget*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void sfml_rendertarget_draw_U2Dmi4(void* self, void* vertex_buffer, void* states) {
    ((RenderTarget*)self)->draw(*(VertexBuffer*)vertex_buffer, *(RenderStates*)states);
}
void sfml_rendertarget_draw_U2Dvgvvgvmi4(void* self, void* vertex_buffer, std::size_t first_vertex, std::size_t vertex_count, void* states) {
    ((RenderTarget*)self)->draw(*(VertexBuffer*)vertex_buffer, first_vertex, vertex_count, *(RenderStates*)states);
}
void sfml_rendertarget_setactive_GZq(void* self, Int8 active, Int8* result) {
    *(bool*)result = ((RenderTarget*)self)->setActive(active != 0);
}
void sfml_rendertarget_pushglstates(void* self) {
    ((RenderTarget*)self)->pushGLStates();
}
void sfml_rendertarget_popglstates(void* self) {
    ((RenderTarget*)self)->popGLStates();
}
void sfml_rendertarget_resetglstates(void* self) {
    ((RenderTarget*)self)->resetGLStates();
}
void sfml_rendertexture_allocate(void** result) {
    *result = malloc(sizeof(RenderTexture));
}
void sfml_rendertexture_free(void* self) {
    free(self);
}
void sfml_rendertexture_initialize(void* self) {
    new(self) RenderTexture();
}
void sfml_rendertexture_finalize(void* self) {
    ((RenderTexture*)self)->~RenderTexture();
}
void sfml_rendertexture_create_emSemSGZq(void* self, unsigned int width, unsigned int height, Int8 depth_buffer, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->create(width, height, depth_buffer != 0);
}
void sfml_rendertexture_create_emSemSFw4(void* self, unsigned int width, unsigned int height, void* settings, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->create(width, height, *(ContextSettings*)settings);
}
void sfml_rendertexture_getmaximumantialiasinglevel(unsigned int* result) {
    *(unsigned int*)result = RenderTexture::getMaximumAntialiasingLevel();
}
void sfml_rendertexture_setsmooth_GZq(void* self, Int8 smooth) {
    ((RenderTexture*)self)->setSmooth(smooth != 0);
}
void sfml_rendertexture_issmooth(void* self, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->isSmooth();
}
void sfml_rendertexture_setrepeated_GZq(void* self, Int8 repeated) {
    ((RenderTexture*)self)->setRepeated(repeated != 0);
}
void sfml_rendertexture_isrepeated(void* self, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->isRepeated();
}
void sfml_rendertexture_generatemipmap(void* self, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->generateMipmap();
}
void sfml_rendertexture_setactive_GZq(void* self, Int8 active, Int8* result) {
    *(bool*)result = ((RenderTexture*)self)->setActive(active != 0);
}
void sfml_rendertexture_display(void* self) {
    ((RenderTexture*)self)->display();
}
void sfml_rendertexture_getsize(void* self, void* result) {
    *(Vector2u*)result = ((RenderTexture*)self)->getSize();
}
void sfml_rendertexture_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(&((RenderTexture*)self)->getTexture());
}
void sfml_rendertexture_clear_QVe(void* self, void* color) {
    ((RenderTexture*)self)->clear(*(Color*)color);
}
void sfml_rendertexture_setview_DDi(void* self, void* view) {
    ((RenderTexture*)self)->setView(*(View*)view);
}
void sfml_rendertexture_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTexture*)self)->getView());
}
void sfml_rendertexture_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTexture*)self)->getDefaultView());
}
void sfml_rendertexture_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderTexture*)self)->getViewport(*(View*)view);
}
void sfml_rendertexture_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderTexture*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void sfml_rendertexture_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderTexture*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void sfml_rendertexture_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderTexture*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void sfml_rendertexture_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderTexture*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void sfml_rendertexture_draw_46svgvu9wmi4(void* self, void* vertices, std::size_t vertex_count, int type, void* states) {
    ((RenderTexture*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void sfml_rendertexture_draw_U2Dmi4(void* self, void* vertex_buffer, void* states) {
    ((RenderTexture*)self)->draw(*(VertexBuffer*)vertex_buffer, *(RenderStates*)states);
}
void sfml_rendertexture_draw_U2Dvgvvgvmi4(void* self, void* vertex_buffer, std::size_t first_vertex, std::size_t vertex_count, void* states) {
    ((RenderTexture*)self)->draw(*(VertexBuffer*)vertex_buffer, first_vertex, vertex_count, *(RenderStates*)states);
}
void sfml_rendertexture_pushglstates(void* self) {
    ((RenderTexture*)self)->pushGLStates();
}
void sfml_rendertexture_popglstates(void* self) {
    ((RenderTexture*)self)->popGLStates();
}
void sfml_rendertexture_resetglstates(void* self) {
    ((RenderTexture*)self)->resetGLStates();
}
void sfml_renderwindow_allocate(void** result) {
    *result = malloc(sizeof(RenderWindow));
}
void sfml_renderwindow_free(void* self) {
    free(self);
}
void sfml_renderwindow_initialize(void* self) {
    new(self) RenderWindow();
}
void sfml_renderwindow_initialize_wg0bQssaLFw4(void* self, void* mode, std::size_t title_size, Uint32* title, Uint32 style, void* settings) {
    new(self) RenderWindow(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), style, *(ContextSettings*)settings);
}
void sfml_renderwindow_initialize_rLQFw4(void* self, WindowHandle handle, void* settings) {
    new(self) RenderWindow(handle, *(ContextSettings*)settings);
}
void sfml_renderwindow_finalize(void* self) {
    ((RenderWindow*)self)->~RenderWindow();
}
void sfml_renderwindow_getsize(void* self, void* result) {
    *(Vector2u*)result = ((RenderWindow*)self)->getSize();
}
void sfml_renderwindow_setactive_GZq(void* self, Int8 active, Int8* result) {
    *(bool*)result = ((RenderWindow*)self)->setActive(active != 0);
}
void sfml_renderwindow_capture(void* self, void* result) {
    *(Image*)result = ((RenderWindow*)self)->capture();
}
void sfml_renderwindow_create_wg0bQssaLFw4(void* self, void* mode, std::size_t title_size, Uint32* title, Uint32 style, void* settings) {
    ((RenderWindow*)self)->create(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), style, *(ContextSettings*)settings);
}
void sfml_renderwindow_create_rLQFw4(void* self, WindowHandle handle, void* settings) {
    ((RenderWindow*)self)->create(handle, *(ContextSettings*)settings);
}
void sfml_renderwindow_close(void* self) {
    ((RenderWindow*)self)->close();
}
void sfml_renderwindow_isopen(void* self, Int8* result) {
    *(bool*)result = ((RenderWindow*)self)->isOpen();
}
void sfml_renderwindow_getsettings(void* self, void* result) {
    *(ContextSettings*)result = ((RenderWindow*)self)->getSettings();
}
void sfml_renderwindow_pollevent_YJW(void* self, void* event, Int8* result) {
    *(bool*)result = ((RenderWindow*)self)->pollEvent(*(Event*)event);
}
void sfml_renderwindow_waitevent_YJW(void* self, void* event, Int8* result) {
    *(bool*)result = ((RenderWindow*)self)->waitEvent(*(Event*)event);
}
void sfml_renderwindow_getposition(void* self, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->getPosition();
}
void sfml_renderwindow_setposition_ufV(void* self, void* position) {
    ((RenderWindow*)self)->setPosition(*(Vector2i*)position);
}
void sfml_renderwindow_setsize_DXO(void* self, void* size) {
    ((RenderWindow*)self)->setSize(*(Vector2u*)size);
}
void sfml_renderwindow_settitle_bQs(void* self, std::size_t title_size, Uint32* title) {
    ((RenderWindow*)self)->setTitle(String::fromUtf32(title, title+title_size));
}
void sfml_renderwindow_seticon_emSemS843(void* self, unsigned int width, unsigned int height, Uint8* pixels) {
    ((RenderWindow*)self)->setIcon(width, height, pixels);
}
void sfml_renderwindow_setvisible_GZq(void* self, Int8 visible) {
    ((RenderWindow*)self)->setVisible(visible != 0);
}
void sfml_renderwindow_setverticalsyncenabled_GZq(void* self, Int8 enabled) {
    ((RenderWindow*)self)->setVerticalSyncEnabled(enabled != 0);
}
void sfml_renderwindow_setmousecursorvisible_GZq(void* self, Int8 visible) {
    ((RenderWindow*)self)->setMouseCursorVisible(visible != 0);
}
void sfml_renderwindow_setmousecursorgrabbed_GZq(void* self, Int8 grabbed) {
    ((RenderWindow*)self)->setMouseCursorGrabbed(grabbed != 0);
}
void sfml_renderwindow_setmousecursor_Voc(void* self, void* cursor) {
    ((RenderWindow*)self)->setMouseCursor(*(Cursor*)cursor);
}
void sfml_renderwindow_setkeyrepeatenabled_GZq(void* self, Int8 enabled) {
    ((RenderWindow*)self)->setKeyRepeatEnabled(enabled != 0);
}
void sfml_renderwindow_setframeratelimit_emS(void* self, unsigned int limit) {
    ((RenderWindow*)self)->setFramerateLimit(limit);
}
void sfml_renderwindow_setjoystickthreshold_Bw9(void* self, float threshold) {
    ((RenderWindow*)self)->setJoystickThreshold(threshold);
}
void sfml_renderwindow_requestfocus(void* self) {
    ((RenderWindow*)self)->requestFocus();
}
void sfml_renderwindow_hasfocus(void* self, Int8* result) {
    *(bool*)result = ((RenderWindow*)self)->hasFocus();
}
void sfml_renderwindow_display(void* self) {
    ((RenderWindow*)self)->display();
}
void sfml_renderwindow_getsystemhandle(void* self, WindowHandle* result) {
    *(WindowHandle*)result = ((RenderWindow*)self)->getSystemHandle();
}
void sfml_renderwindow_clear_QVe(void* self, void* color) {
    ((RenderWindow*)self)->clear(*(Color*)color);
}
void sfml_renderwindow_setview_DDi(void* self, void* view) {
    ((RenderWindow*)self)->setView(*(View*)view);
}
void sfml_renderwindow_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderWindow*)self)->getView());
}
void sfml_renderwindow_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderWindow*)self)->getDefaultView());
}
void sfml_renderwindow_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderWindow*)self)->getViewport(*(View*)view);
}
void sfml_renderwindow_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderWindow*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void sfml_renderwindow_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderWindow*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void sfml_renderwindow_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void sfml_renderwindow_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void sfml_renderwindow_draw_46svgvu9wmi4(void* self, void* vertices, std::size_t vertex_count, int type, void* states) {
    ((RenderWindow*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void sfml_renderwindow_draw_U2Dmi4(void* self, void* vertex_buffer, void* states) {
    ((RenderWindow*)self)->draw(*(VertexBuffer*)vertex_buffer, *(RenderStates*)states);
}
void sfml_renderwindow_draw_U2Dvgvvgvmi4(void* self, void* vertex_buffer, std::size_t first_vertex, std::size_t vertex_count, void* states) {
    ((RenderWindow*)self)->draw(*(VertexBuffer*)vertex_buffer, first_vertex, vertex_count, *(RenderStates*)states);
}
void sfml_renderwindow_pushglstates(void* self) {
    ((RenderWindow*)self)->pushGLStates();
}
void sfml_renderwindow_popglstates(void* self) {
    ((RenderWindow*)self)->popGLStates();
}
void sfml_renderwindow_resetglstates(void* self) {
    ((RenderWindow*)self)->resetGLStates();
}
void sfml_shader_allocate(void** result) {
    *result = malloc(sizeof(Shader));
}
void sfml_shader_free(void* self) {
    free(self);
}
void sfml_shader_initialize(void* self) {
    new(self) Shader();
}
void sfml_shader_finalize(void* self) {
    ((Shader*)self)->~Shader();
}
void sfml_shader_loadfromfile_zkCqL0(void* self, std::size_t filename_size, char* filename, int type, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromFile(std::string(filename, filename_size), (Shader::Type)type);
}
void sfml_shader_loadfromfile_zkCzkC(void* self, std::size_t vertex_shader_filename_size, char* vertex_shader_filename, std::size_t fragment_shader_filename_size, char* fragment_shader_filename, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromFile(std::string(vertex_shader_filename, vertex_shader_filename_size), std::string(fragment_shader_filename, fragment_shader_filename_size));
}
void sfml_shader_loadfromfile_zkCzkCzkC(void* self, std::size_t vertex_shader_filename_size, char* vertex_shader_filename, std::size_t geometry_shader_filename_size, char* geometry_shader_filename, std::size_t fragment_shader_filename_size, char* fragment_shader_filename, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromFile(std::string(vertex_shader_filename, vertex_shader_filename_size), std::string(geometry_shader_filename, geometry_shader_filename_size), std::string(fragment_shader_filename, fragment_shader_filename_size));
}
void sfml_shader_loadfrommemory_zkCqL0(void* self, std::size_t shader_size, char* shader, int type, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromMemory(std::string(shader, shader_size), (Shader::Type)type);
}
void sfml_shader_loadfrommemory_zkCzkC(void* self, std::size_t vertex_shader_size, char* vertex_shader, std::size_t fragment_shader_size, char* fragment_shader, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromMemory(std::string(vertex_shader, vertex_shader_size), std::string(fragment_shader, fragment_shader_size));
}
void sfml_shader_loadfrommemory_zkCzkCzkC(void* self, std::size_t vertex_shader_size, char* vertex_shader, std::size_t geometry_shader_size, char* geometry_shader, std::size_t fragment_shader_size, char* fragment_shader, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromMemory(std::string(vertex_shader, vertex_shader_size), std::string(geometry_shader, geometry_shader_size), std::string(fragment_shader, fragment_shader_size));
}
void sfml_shader_loadfromstream_PO0qL0(void* self, void* stream, int type, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromStream(*(InputStream*)stream, (Shader::Type)type);
}
void sfml_shader_loadfromstream_PO0PO0(void* self, void* vertex_shader_stream, void* fragment_shader_stream, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromStream(*(InputStream*)vertex_shader_stream, *(InputStream*)fragment_shader_stream);
}
void sfml_shader_loadfromstream_PO0PO0PO0(void* self, void* vertex_shader_stream, void* geometry_shader_stream, void* fragment_shader_stream, Int8* result) {
    *(bool*)result = ((Shader*)self)->loadFromStream(*(InputStream*)vertex_shader_stream, *(InputStream*)geometry_shader_stream, *(InputStream*)fragment_shader_stream);
}
void sfml_shader_setparameter_zkCBw9(void* self, std::size_t name_size, char* name, float x) {
    ((Shader*)self)->setParameter(std::string(name, name_size), x);
}
void sfml_shader_setparameter_zkCBw9Bw9(void* self, std::size_t name_size, char* name, float x, float y) {
    ((Shader*)self)->setParameter(std::string(name, name_size), x, y);
}
void sfml_shader_setparameter_zkCBw9Bw9Bw9(void* self, std::size_t name_size, char* name, float x, float y, float z) {
    ((Shader*)self)->setParameter(std::string(name, name_size), x, y, z);
}
void sfml_shader_setparameter_zkCBw9Bw9Bw9Bw9(void* self, std::size_t name_size, char* name, float x, float y, float z, float w) {
    ((Shader*)self)->setParameter(std::string(name, name_size), x, y, z, w);
}
void sfml_shader_setparameter_zkCUU2(void* self, std::size_t name_size, char* name, void* vector) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Vector2f*)vector);
}
void sfml_shader_setparameter_zkCNzM(void* self, std::size_t name_size, char* name, void* vector) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Vector3f*)vector);
}
void sfml_shader_setparameter_zkCQVe(void* self, std::size_t name_size, char* name, void* color) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Color*)color);
}
void sfml_shader_setparameter_zkCFPe(void* self, std::size_t name_size, char* name, void* transform) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Transform*)transform);
}
void sfml_shader_setparameter_zkCDJb(void* self, std::size_t name_size, char* name, void* texture) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Texture*)texture);
}
void sfml_shader_setparameter_zkCLcV(void* self, std::size_t name_size, char* name) {
    ((Shader*)self)->setParameter(std::string(name, name_size), Shader::CurrentTexture);
}
void sfml_shader_getnativehandle(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Shader*)self)->getNativeHandle();
}
void sfml_shader_bind_8P6(void* shader) {
    Shader::bind((Shader*)shader);
}
void sfml_shader_isavailable(Int8* result) {
    *(bool*)result = Shader::isAvailable();
}
void sfml_shader_isgeometryavailable(Int8* result) {
    *(bool*)result = Shader::isGeometryAvailable();
}
void sfml_sprite_allocate(void** result) {
    *result = malloc(sizeof(Sprite));
}
void sfml_sprite_finalize(void* self) {
    ((Sprite*)self)->~Sprite();
}
void sfml_sprite_free(void* self) {
    free(self);
}
void sfml_sprite_initialize(void* self) {
    new(self) Sprite();
}
void sfml_sprite_initialize_DJb(void* self, void* texture) {
    new(self) Sprite(*(Texture*)texture);
}
void sfml_sprite_initialize_DJb2k1(void* self, void* texture, void* rectangle) {
    new(self) Sprite(*(Texture*)texture, *(IntRect*)rectangle);
}
void sfml_sprite_settexture_DJbGZq(void* self, void* texture, Int8 reset_rect) {
    ((Sprite*)self)->setTexture(*(Texture*)texture, reset_rect != 0);
}
void sfml_sprite_settexturerect_2k1(void* self, void* rectangle) {
    ((Sprite*)self)->setTextureRect(*(IntRect*)rectangle);
}
void sfml_sprite_setcolor_QVe(void* self, void* color) {
    ((Sprite*)self)->setColor(*(Color*)color);
}
void sfml_sprite_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((Sprite*)self)->getTexture());
}
void sfml_sprite_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((Sprite*)self)->getTextureRect();
}
void sfml_sprite_getcolor(void* self, void* result) {
    *(Color*)result = ((Sprite*)self)->getColor();
}
void sfml_sprite_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Sprite*)self)->getLocalBounds();
}
void sfml_sprite_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Sprite*)self)->getGlobalBounds();
}
void sfml_sprite_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Sprite*)self)->setPosition(x, y);
}
void sfml_sprite_setposition_UU2(void* self, void* position) {
    ((Sprite*)self)->setPosition(*(Vector2f*)position);
}
void sfml_sprite_setrotation_Bw9(void* self, float angle) {
    ((Sprite*)self)->setRotation(angle);
}
void sfml_sprite_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Sprite*)self)->setScale(factor_x, factor_y);
}
void sfml_sprite_setscale_UU2(void* self, void* factors) {
    ((Sprite*)self)->setScale(*(Vector2f*)factors);
}
void sfml_sprite_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Sprite*)self)->setOrigin(x, y);
}
void sfml_sprite_setorigin_UU2(void* self, void* origin) {
    ((Sprite*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_sprite_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getPosition();
}
void sfml_sprite_getrotation(void* self, float* result) {
    *(float*)result = ((Sprite*)self)->getRotation();
}
void sfml_sprite_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getScale();
}
void sfml_sprite_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getOrigin();
}
void sfml_sprite_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Sprite*)self)->move(offset_x, offset_y);
}
void sfml_sprite_move_UU2(void* self, void* offset) {
    ((Sprite*)self)->move(*(Vector2f*)offset);
}
void sfml_sprite_rotate_Bw9(void* self, float angle) {
    ((Sprite*)self)->rotate(angle);
}
void sfml_sprite_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Sprite*)self)->scale(factor_x, factor_y);
}
void sfml_sprite_scale_UU2(void* self, void* factor) {
    ((Sprite*)self)->scale(*(Vector2f*)factor);
}
void sfml_sprite_gettransform(void* self, void* result) {
    *(Transform*)result = ((Sprite*)self)->getTransform();
}
void sfml_sprite_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Sprite*)self)->getInverseTransform();
}
void sfml_sprite_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sfml_sprite_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sfml_sprite_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sfml_sprite_initialize_8xu(void* self, void* copy) {
    new(self) Sprite(*(Sprite*)copy);
}
void sfml_text_allocate(void** result) {
    *result = malloc(sizeof(Text));
}
void sfml_text_finalize(void* self) {
    ((Text*)self)->~Text();
}
void sfml_text_free(void* self) {
    free(self);
}
void sfml_text_initialize(void* self) {
    new(self) Text();
}
void sfml_text_initialize_bQs7CFemS(void* self, std::size_t string_size, Uint32* string, void* font, unsigned int character_size) {
    new(self) Text(String::fromUtf32(string, string+string_size), *(Font*)font, character_size);
}
void sfml_text_setstring_bQs(void* self, std::size_t string_size, Uint32* string) {
    ((Text*)self)->setString(String::fromUtf32(string, string+string_size));
}
void sfml_text_setfont_7CF(void* self, void* font) {
    ((Text*)self)->setFont(*(Font*)font);
}
void sfml_text_setcharactersize_emS(void* self, unsigned int size) {
    ((Text*)self)->setCharacterSize(size);
}
void sfml_text_setlinespacing_Bw9(void* self, float spacing_factor) {
    ((Text*)self)->setLineSpacing(spacing_factor);
}
void sfml_text_setletterspacing_Bw9(void* self, float spacing_factor) {
    ((Text*)self)->setLetterSpacing(spacing_factor);
}
void sfml_text_setstyle_saL(void* self, Uint32 style) {
    ((Text*)self)->setStyle(style);
}
void sfml_text_setcolor_QVe(void* self, void* color) {
    ((Text*)self)->setColor(*(Color*)color);
}
void sfml_text_setfillcolor_QVe(void* self, void* color) {
    ((Text*)self)->setFillColor(*(Color*)color);
}
void sfml_text_setoutlinecolor_QVe(void* self, void* color) {
    ((Text*)self)->setOutlineColor(*(Color*)color);
}
void sfml_text_setoutlinethickness_Bw9(void* self, float thickness) {
    ((Text*)self)->setOutlineThickness(thickness);
}
void sfml_text_getstring(void* self, Uint32** result) {
    static String str;
    str = ((Text*)self)->getString();
    *result = const_cast<Uint32*>(str.getData());
}
void sfml_text_getfont(void* self, void** result) {
    *(Font**)result = const_cast<Font*>(((Text*)self)->getFont());
}
void sfml_text_getcharactersize(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Text*)self)->getCharacterSize();
}
void sfml_text_getletterspacing(void* self, float* result) {
    *(float*)result = ((Text*)self)->getLetterSpacing();
}
void sfml_text_getlinespacing(void* self, float* result) {
    *(float*)result = ((Text*)self)->getLineSpacing();
}
void sfml_text_getstyle(void* self, Uint32* result) {
    *(Uint32*)result = ((Text*)self)->getStyle();
}
void sfml_text_getcolor(void* self, void* result) {
    *(Color*)result = ((Text*)self)->getColor();
}
void sfml_text_getfillcolor(void* self, void* result) {
    *(Color*)result = ((Text*)self)->getFillColor();
}
void sfml_text_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((Text*)self)->getOutlineColor();
}
void sfml_text_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((Text*)self)->getOutlineThickness();
}
void sfml_text_findcharacterpos_vgv(void* self, std::size_t index, void* result) {
    *(Vector2f*)result = ((Text*)self)->findCharacterPos(index);
}
void sfml_text_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Text*)self)->getLocalBounds();
}
void sfml_text_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Text*)self)->getGlobalBounds();
}
void sfml_text_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Text*)self)->setPosition(x, y);
}
void sfml_text_setposition_UU2(void* self, void* position) {
    ((Text*)self)->setPosition(*(Vector2f*)position);
}
void sfml_text_setrotation_Bw9(void* self, float angle) {
    ((Text*)self)->setRotation(angle);
}
void sfml_text_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Text*)self)->setScale(factor_x, factor_y);
}
void sfml_text_setscale_UU2(void* self, void* factors) {
    ((Text*)self)->setScale(*(Vector2f*)factors);
}
void sfml_text_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Text*)self)->setOrigin(x, y);
}
void sfml_text_setorigin_UU2(void* self, void* origin) {
    ((Text*)self)->setOrigin(*(Vector2f*)origin);
}
void sfml_text_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getPosition();
}
void sfml_text_getrotation(void* self, float* result) {
    *(float*)result = ((Text*)self)->getRotation();
}
void sfml_text_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getScale();
}
void sfml_text_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getOrigin();
}
void sfml_text_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Text*)self)->move(offset_x, offset_y);
}
void sfml_text_move_UU2(void* self, void* offset) {
    ((Text*)self)->move(*(Vector2f*)offset);
}
void sfml_text_rotate_Bw9(void* self, float angle) {
    ((Text*)self)->rotate(angle);
}
void sfml_text_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Text*)self)->scale(factor_x, factor_y);
}
void sfml_text_scale_UU2(void* self, void* factor) {
    ((Text*)self)->scale(*(Vector2f*)factor);
}
void sfml_text_gettransform(void* self, void* result) {
    *(Transform*)result = ((Text*)self)->getTransform();
}
void sfml_text_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Text*)self)->getInverseTransform();
}
void sfml_text_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void sfml_text_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void sfml_text_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void sfml_text_initialize_clM(void* self, void* copy) {
    new(self) Text(*(Text*)copy);
}
void sfml_vertexbuffer_allocate(void** result) {
    *result = malloc(sizeof(VertexBuffer));
}
void sfml_vertexbuffer_free(void* self) {
    free(self);
}
void sfml_vertexbuffer_initialize(void* self) {
    new(self) VertexBuffer();
}
void sfml_vertexbuffer_initialize_u9w(void* self, int type) {
    new(self) VertexBuffer((PrimitiveType)type);
}
void sfml_vertexbuffer_initialize_9vK(void* self, int usage) {
    new(self) VertexBuffer((VertexBuffer::Usage)usage);
}
void sfml_vertexbuffer_initialize_u9w9vK(void* self, int type, int usage) {
    new(self) VertexBuffer((PrimitiveType)type, (VertexBuffer::Usage)usage);
}
void sfml_vertexbuffer_finalize(void* self) {
    ((VertexBuffer*)self)->~VertexBuffer();
}
void sfml_vertexbuffer_create_vgv(void* self, std::size_t vertex_count, Int8* result) {
    *(bool*)result = ((VertexBuffer*)self)->create(vertex_count);
}
void sfml_vertexbuffer_getvertexcount(void* self, std::size_t* result) {
    *(std::size_t*)result = ((VertexBuffer*)self)->getVertexCount();
}
void sfml_vertexbuffer_update_46s(void* self, void* vertices, Int8* result) {
    *(bool*)result = ((VertexBuffer*)self)->update((Vertex*)vertices);
}
void sfml_vertexbuffer_update_46svgvemS(void* self, void* vertices, std::size_t vertex_count, unsigned int offset, Int8* result) {
    *(bool*)result = ((VertexBuffer*)self)->update((Vertex*)vertices, vertex_count, offset);
}
void sfml_vertexbuffer_update_U2D(void* self, void* vertex_buffer, Int8* result) {
    *(bool*)result = ((VertexBuffer*)self)->update(*(VertexBuffer*)vertex_buffer);
}
void sfml_vertexbuffer_swap_8jC(void* self, void* right) {
    ((VertexBuffer*)self)->swap(*(VertexBuffer*)right);
}
void sfml_vertexbuffer_getnativehandle(void* self, unsigned int* result) {
    *(unsigned int*)result = ((VertexBuffer*)self)->getNativeHandle();
}
void sfml_vertexbuffer_setprimitivetype_u9w(void* self, int type) {
    ((VertexBuffer*)self)->setPrimitiveType((PrimitiveType)type);
}
void sfml_vertexbuffer_getprimitivetype(void* self, int* result) {
    *(PrimitiveType*)result = ((VertexBuffer*)self)->getPrimitiveType();
}
void sfml_vertexbuffer_setusage_9vK(void* self, int usage) {
    ((VertexBuffer*)self)->setUsage((VertexBuffer::Usage)usage);
}
void sfml_vertexbuffer_getusage(void* self, int* result) {
    *(VertexBuffer::Usage*)result = ((VertexBuffer*)self)->getUsage();
}
void sfml_vertexbuffer_bind_Kfe(void* vertex_buffer) {
    VertexBuffer::bind((VertexBuffer*)vertex_buffer);
}
void sfml_vertexbuffer_isavailable(Int8* result) {
    *(bool*)result = VertexBuffer::isAvailable();
}
void sfml_vertexbuffer_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(VertexBuffer*)self, *(RenderStates*)states);
}
void sfml_vertexbuffer_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(VertexBuffer*)self, *(RenderStates*)states);
}
void sfml_vertexbuffer_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(VertexBuffer*)self, *(RenderStates*)states);
}
void sfml_vertexbuffer_initialize_U2D(void* self, void* copy) {
    new(self) VertexBuffer(*(VertexBuffer*)copy);
}
void sfml_graphics_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
}
