#include <voidcsfml/graphics.h>
#include <SFML/Graphics.hpp>
using namespace sf;
void blendmode_initialize(void* self) {
    new(self) BlendMode();
}
void blendmode_initialize_8xr8xrBw1(void* self, int source_factor, int destination_factor, int blend_equation) {
    new(self) BlendMode((BlendMode::Factor)source_factor, (BlendMode::Factor)destination_factor, (BlendMode::Equation)blend_equation);
}
void blendmode_initialize_8xr8xrBw18xr8xrBw1(void* self, int color_source_factor, int color_destination_factor, int color_blend_equation, int alpha_source_factor, int alpha_destination_factor, int alpha_blend_equation) {
    new(self) BlendMode((BlendMode::Factor)color_source_factor, (BlendMode::Factor)color_destination_factor, (BlendMode::Equation)color_blend_equation, (BlendMode::Factor)alpha_source_factor, (BlendMode::Factor)alpha_destination_factor, (BlendMode::Equation)alpha_blend_equation);
}
void blendmode_setcolorsrcfactor_8xr(void* self, int color_src_factor) {
    ((BlendMode*)self)->colorSrcFactor = (BlendMode::Factor)color_src_factor;
}
void blendmode_setcolordstfactor_8xr(void* self, int color_dst_factor) {
    ((BlendMode*)self)->colorDstFactor = (BlendMode::Factor)color_dst_factor;
}
void blendmode_setcolorequation_Bw1(void* self, int color_equation) {
    ((BlendMode*)self)->colorEquation = (BlendMode::Equation)color_equation;
}
void blendmode_setalphasrcfactor_8xr(void* self, int alpha_src_factor) {
    ((BlendMode*)self)->alphaSrcFactor = (BlendMode::Factor)alpha_src_factor;
}
void blendmode_setalphadstfactor_8xr(void* self, int alpha_dst_factor) {
    ((BlendMode*)self)->alphaDstFactor = (BlendMode::Factor)alpha_dst_factor;
}
void blendmode_setalphaequation_Bw1(void* self, int alpha_equation) {
    ((BlendMode*)self)->alphaEquation = (BlendMode::Equation)alpha_equation;
}
void operator_eq_PG5PG5(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(BlendMode*)left, *(BlendMode*)right);
}
void operator_ne_PG5PG5(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(BlendMode*)left, *(BlendMode*)right);
}
void blendmode_initialize_PG5(void* self, void* copy) {
    new(self) BlendMode(*(BlendMode*)copy);
}
void transform_initialize(void* self) {
    new(self) Transform();
}
void transform_initialize_Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9(void* self, float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22) {
    new(self) Transform((float)a00, (float)a01, (float)a02, (float)a10, (float)a11, (float)a12, (float)a20, (float)a21, (float)a22);
}
void transform_getmatrix(void* self, float** result) {
    *(float**)result = const_cast<float*>(((Transform*)self)->getMatrix());
}
void transform_getinverse(void* self, void* result) {
    *(Transform*)result = ((Transform*)self)->getInverse();
}
void transform_transformpoint_Bw9Bw9(void* self, float x, float y, void* result) {
    *(Vector2f*)result = ((Transform*)self)->transformPoint((float)x, (float)y);
}
void transform_transformpoint_UU2(void* self, void* point, void* result) {
    *(Vector2f*)result = ((Transform*)self)->transformPoint(*(Vector2f*)point);
}
void transform_transformrect_WPZ(void* self, void* rectangle, void* result) {
    *(FloatRect*)result = ((Transform*)self)->transformRect(*(FloatRect*)rectangle);
}
void transform_combine_FPe(void* self, void* transform, void* result) {
    *(Transform*)result = ((Transform*)self)->combine(*(Transform*)transform);
}
void transform_translate_Bw9Bw9(void* self, float x, float y, void* result) {
    *(Transform*)result = ((Transform*)self)->translate((float)x, (float)y);
}
void transform_translate_UU2(void* self, void* offset, void* result) {
    *(Transform*)result = ((Transform*)self)->translate(*(Vector2f*)offset);
}
void transform_rotate_Bw9(void* self, float angle, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate((float)angle);
}
void transform_rotate_Bw9Bw9Bw9(void* self, float angle, float center_x, float center_y, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate((float)angle, (float)center_x, (float)center_y);
}
void transform_rotate_Bw9UU2(void* self, float angle, void* center, void* result) {
    *(Transform*)result = ((Transform*)self)->rotate((float)angle, *(Vector2f*)center);
}
void transform_scale_Bw9Bw9(void* self, float scale_x, float scale_y, void* result) {
    *(Transform*)result = ((Transform*)self)->scale((float)scale_x, (float)scale_y);
}
void transform_scale_Bw9Bw9Bw9Bw9(void* self, float scale_x, float scale_y, float center_x, float center_y, void* result) {
    *(Transform*)result = ((Transform*)self)->scale((float)scale_x, (float)scale_y, (float)center_x, (float)center_y);
}
void transform_scale_UU2(void* self, void* factors, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(*(Vector2f*)factors);
}
void transform_scale_UU2UU2(void* self, void* factors, void* center, void* result) {
    *(Transform*)result = ((Transform*)self)->scale(*(Vector2f*)factors, *(Vector2f*)center);
}
void operator_mul_FPeFPe(void* left, void* right, void* result) {
    *(Transform*)result = operator*(*(Transform*)left, *(Transform*)right);
}
void operator_mul_FPeUU2(void* left, void* right, void* result) {
    *(Vector2f*)result = operator*(*(Transform*)left, *(Vector2f*)right);
}
void transform_initialize_FPe(void* self, void* copy) {
    new(self) Transform(*(Transform*)copy);
}
void renderstates_initialize(void* self) {
    new(self) RenderStates();
}
void renderstates_initialize_PG5(void* self, void* blend_mode) {
    new(self) RenderStates(*(BlendMode*)blend_mode);
}
void renderstates_initialize_FPe(void* self, void* transform) {
    new(self) RenderStates(*(Transform*)transform);
}
void renderstates_initialize_MXd(void* self, void* texture) {
    new(self) RenderStates((Texture*)texture);
}
void renderstates_initialize_8P6(void* self, void* shader) {
    new(self) RenderStates((Shader*)shader);
}
void renderstates_initialize_PG5FPeMXd8P6(void* self, void* blend_mode, void* transform, void* texture, void* shader) {
    new(self) RenderStates(*(BlendMode*)blend_mode, *(Transform*)transform, (Texture*)texture, (Shader*)shader);
}
void renderstates_setblendmode_CPE(void* self, void* blend_mode) {
    ((RenderStates*)self)->blendMode = *(BlendMode*)blend_mode;
}
void renderstates_settransform_lbe(void* self, void* transform) {
    ((RenderStates*)self)->transform = *(Transform*)transform;
}
void renderstates_settexture_MXd(void* self, void* texture) {
    ((RenderStates*)self)->texture = (Texture*)texture;
}
void renderstates_setshader_8P6(void* self, void* shader) {
    ((RenderStates*)self)->shader = (Shader*)shader;
}
void renderstates_initialize_mi4(void* self, void* copy) {
    new(self) RenderStates(*(RenderStates*)copy);
}
void transformable_initialize(void* self) {
    new(self) Transformable();
}
void transformable_finalize(void* self) {
    ((Transformable*)self)->~Transformable();
}
void transformable_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Transformable*)self)->setPosition((float)x, (float)y);
}
void transformable_setposition_UU2(void* self, void* position) {
    ((Transformable*)self)->setPosition(*(Vector2f*)position);
}
void transformable_setrotation_Bw9(void* self, float angle) {
    ((Transformable*)self)->setRotation((float)angle);
}
void transformable_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Transformable*)self)->setScale((float)factor_x, (float)factor_y);
}
void transformable_setscale_UU2(void* self, void* factors) {
    ((Transformable*)self)->setScale(*(Vector2f*)factors);
}
void transformable_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Transformable*)self)->setOrigin((float)x, (float)y);
}
void transformable_setorigin_UU2(void* self, void* origin) {
    ((Transformable*)self)->setOrigin(*(Vector2f*)origin);
}
void transformable_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getPosition();
}
void transformable_getrotation(void* self, float* result) {
    *(float*)result = ((Transformable*)self)->getRotation();
}
void transformable_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getScale();
}
void transformable_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Transformable*)self)->getOrigin();
}
void transformable_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Transformable*)self)->move((float)offset_x, (float)offset_y);
}
void transformable_move_UU2(void* self, void* offset) {
    ((Transformable*)self)->move(*(Vector2f*)offset);
}
void transformable_rotate_Bw9(void* self, float angle) {
    ((Transformable*)self)->rotate((float)angle);
}
void transformable_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Transformable*)self)->scale((float)factor_x, (float)factor_y);
}
void transformable_scale_UU2(void* self, void* factor) {
    ((Transformable*)self)->scale(*(Vector2f*)factor);
}
void transformable_gettransform(void* self, void* result) {
    *(Transform*)result = ((Transformable*)self)->getTransform();
}
void transformable_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Transformable*)self)->getInverseTransform();
}
void transformable_initialize_dkg(void* self, void* copy) {
    new(self) Transformable(*(Transformable*)copy);
}
void color_initialize(void* self) {
    new(self) Color();
}
void color_initialize_9yU9yU9yU9yU(void* self, uint8_t red, uint8_t green, uint8_t blue, uint8_t alpha) {
    new(self) Color((Uint8)red, (Uint8)green, (Uint8)blue, (Uint8)alpha);
}
void color_initialize_saL(void* self, uint32_t color) {
    new(self) Color((Uint32)color);
}
void color_tointeger(void* self, uint32_t* result) {
    *(Uint32*)result = ((Color*)self)->toInteger();
}
void color_setr_9yU(void* self, uint8_t r) {
    ((Color*)self)->r = (Uint8)r;
}
void color_setg_9yU(void* self, uint8_t g) {
    ((Color*)self)->g = (Uint8)g;
}
void color_setb_9yU(void* self, uint8_t b) {
    ((Color*)self)->b = (Uint8)b;
}
void color_seta_9yU(void* self, uint8_t a) {
    ((Color*)self)->a = (Uint8)a;
}
void operator_eq_QVeQVe(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(Color*)left, *(Color*)right);
}
void operator_ne_QVeQVe(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(Color*)left, *(Color*)right);
}
void operator_add_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator+(*(Color*)left, *(Color*)right);
}
void operator_sub_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator-(*(Color*)left, *(Color*)right);
}
void operator_mul_QVeQVe(void* left, void* right, void* result) {
    *(Color*)result = operator*(*(Color*)left, *(Color*)right);
}
void color_initialize_QVe(void* self, void* copy) {
    new(self) Color(*(Color*)copy);
}
void vertex_initialize(void* self) {
    new(self) Vertex();
}
void vertex_initialize_UU2(void* self, void* position) {
    new(self) Vertex(*(Vector2f*)position);
}
void vertex_initialize_UU2QVe(void* self, void* position, void* color) {
    new(self) Vertex(*(Vector2f*)position, *(Color*)color);
}
void vertex_initialize_UU2UU2(void* self, void* position, void* tex_coords) {
    new(self) Vertex(*(Vector2f*)position, *(Vector2f*)tex_coords);
}
void vertex_initialize_UU2QVeUU2(void* self, void* position, void* color, void* tex_coords) {
    new(self) Vertex(*(Vector2f*)position, *(Color*)color, *(Vector2f*)tex_coords);
}
void vertex_setposition_llt(void* self, void* position) {
    ((Vertex*)self)->position = *(Vector2f*)position;
}
void vertex_setcolor_9qU(void* self, void* color) {
    ((Vertex*)self)->color = *(Color*)color;
}
void vertex_settexcoords_llt(void* self, void* tex_coords) {
    ((Vertex*)self)->texCoords = *(Vector2f*)tex_coords;
}
void vertex_initialize_Y3J(void* self, void* copy) {
    new(self) Vertex(*(Vertex*)copy);
}
void vertexarray_initialize(void* self) {
    new(self) VertexArray();
}
void vertexarray_initialize_u9wvgv(void* self, int type, size_t vertex_count) {
    new(self) VertexArray((PrimitiveType)type, (std::size_t)vertex_count);
}
void vertexarray_getvertexcount(void* self, size_t* result) {
    *(std::size_t*)result = ((VertexArray*)self)->getVertexCount();
}
void vertexarray_operator_indexset_vgvpCR(void* self, size_t index, void* value) {
    ((VertexArray*)self)->operator[]((std::size_t)index) = *(Vertex*)value;
}
void vertexarray_operator_index_vgv(void* self, size_t index, void* result) {
    *(Vertex*)result = ((VertexArray*)self)->operator[]((std::size_t)index);
}
void vertexarray_clear(void* self) {
    ((VertexArray*)self)->clear();
}
void vertexarray_resize_vgv(void* self, size_t vertex_count) {
    ((VertexArray*)self)->resize((std::size_t)vertex_count);
}
void vertexarray_append_Y3J(void* self, void* vertex) {
    ((VertexArray*)self)->append(*(Vertex*)vertex);
}
void vertexarray_setprimitivetype_u9w(void* self, int type) {
    ((VertexArray*)self)->setPrimitiveType((PrimitiveType)type);
}
void vertexarray_getprimitivetype(void* self, int* result) {
    *(PrimitiveType*)result = ((VertexArray*)self)->getPrimitiveType();
}
void vertexarray_getbounds(void* self, void* result) {
    *(FloatRect*)result = ((VertexArray*)self)->getBounds();
}
void vertexarray_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void vertexarray_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void vertexarray_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(VertexArray*)self, *(RenderStates*)states);
}
void vertexarray_initialize_EXB(void* self, void* copy) {
    new(self) VertexArray(*(VertexArray*)copy);
}
class _Shape : public sf::Shape {
public:
    virtual std::size_t getPointCount() const {
        std::size_t result;
        shape_getpointcount_callback((void*)this, (size_t*)&result);
        return result;
    }
    virtual Vector2f getPoint(std::size_t index) const {
        Vector2f result;
        shape_getpoint_callback((void*)this, (size_t)index, &result);
        return result;
    }
    using Shape::update;
};
void (*shape_getpointcount_callback)(void*, size_t*) = 0;
void (*shape_getpoint_callback)(void*, size_t, void*) = 0;
void shape_finalize(void* self) {
    ((_Shape*)self)->~_Shape();
}
void shape_settexture_MXdGZq(void* self, void* texture, unsigned char reset_rect) {
    ((_Shape*)self)->setTexture((Texture*)texture, (bool)reset_rect);
}
void shape_settexturerect_2k1(void* self, void* rect) {
    ((_Shape*)self)->setTextureRect(*(IntRect*)rect);
}
void shape_setfillcolor_QVe(void* self, void* color) {
    ((_Shape*)self)->setFillColor(*(Color*)color);
}
void shape_setoutlinecolor_QVe(void* self, void* color) {
    ((_Shape*)self)->setOutlineColor(*(Color*)color);
}
void shape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((_Shape*)self)->setOutlineThickness((float)thickness);
}
void shape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((_Shape*)self)->getTexture());
}
void shape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((_Shape*)self)->getTextureRect();
}
void shape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((_Shape*)self)->getFillColor();
}
void shape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((_Shape*)self)->getOutlineColor();
}
void shape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((_Shape*)self)->getOutlineThickness();
}
void shape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((_Shape*)self)->getLocalBounds();
}
void shape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((_Shape*)self)->getGlobalBounds();
}
void shape_initialize(void* self) {
    new(self) _Shape();
}
void shape_update(void* self) {
    ((_Shape*)self)->update();
}
void shape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((_Shape*)self)->setPosition((float)x, (float)y);
}
void shape_setposition_UU2(void* self, void* position) {
    ((_Shape*)self)->setPosition(*(Vector2f*)position);
}
void shape_setrotation_Bw9(void* self, float angle) {
    ((_Shape*)self)->setRotation((float)angle);
}
void shape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((_Shape*)self)->setScale((float)factor_x, (float)factor_y);
}
void shape_setscale_UU2(void* self, void* factors) {
    ((_Shape*)self)->setScale(*(Vector2f*)factors);
}
void shape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((_Shape*)self)->setOrigin((float)x, (float)y);
}
void shape_setorigin_UU2(void* self, void* origin) {
    ((_Shape*)self)->setOrigin(*(Vector2f*)origin);
}
void shape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getPosition();
}
void shape_getrotation(void* self, float* result) {
    *(float*)result = ((_Shape*)self)->getRotation();
}
void shape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getScale();
}
void shape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((_Shape*)self)->getOrigin();
}
void shape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((_Shape*)self)->move((float)offset_x, (float)offset_y);
}
void shape_move_UU2(void* self, void* offset) {
    ((_Shape*)self)->move(*(Vector2f*)offset);
}
void shape_rotate_Bw9(void* self, float angle) {
    ((_Shape*)self)->rotate((float)angle);
}
void shape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((_Shape*)self)->scale((float)factor_x, (float)factor_y);
}
void shape_scale_UU2(void* self, void* factor) {
    ((_Shape*)self)->scale(*(Vector2f*)factor);
}
void shape_gettransform(void* self, void* result) {
    *(Transform*)result = ((_Shape*)self)->getTransform();
}
void shape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((_Shape*)self)->getInverseTransform();
}
void shape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void shape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void shape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(_Shape*)self, *(RenderStates*)states);
}
void shape_initialize_r5K(void* self, void* copy) {
    new(self) _Shape(*(_Shape*)copy);
}
void circleshape_initialize_Bw9vgv(void* self, float radius, size_t point_count) {
    new(self) CircleShape((float)radius, (std::size_t)point_count);
}
void circleshape_setradius_Bw9(void* self, float radius) {
    ((CircleShape*)self)->setRadius((float)radius);
}
void circleshape_getradius(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getRadius();
}
void circleshape_setpointcount_vgv(void* self, size_t count) {
    ((CircleShape*)self)->setPointCount((std::size_t)count);
}
void circleshape_getpointcount(void* self, size_t* result) {
    *(std::size_t*)result = ((CircleShape*)self)->getPointCount();
}
void circleshape_getpoint_vgv(void* self, size_t index, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getPoint((std::size_t)index);
}
void circleshape_settexture_MXdGZq(void* self, void* texture, unsigned char reset_rect) {
    ((CircleShape*)self)->setTexture((Texture*)texture, (bool)reset_rect);
}
void circleshape_settexturerect_2k1(void* self, void* rect) {
    ((CircleShape*)self)->setTextureRect(*(IntRect*)rect);
}
void circleshape_setfillcolor_QVe(void* self, void* color) {
    ((CircleShape*)self)->setFillColor(*(Color*)color);
}
void circleshape_setoutlinecolor_QVe(void* self, void* color) {
    ((CircleShape*)self)->setOutlineColor(*(Color*)color);
}
void circleshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((CircleShape*)self)->setOutlineThickness((float)thickness);
}
void circleshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((CircleShape*)self)->getTexture());
}
void circleshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((CircleShape*)self)->getTextureRect();
}
void circleshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((CircleShape*)self)->getFillColor();
}
void circleshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((CircleShape*)self)->getOutlineColor();
}
void circleshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getOutlineThickness();
}
void circleshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((CircleShape*)self)->getLocalBounds();
}
void circleshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((CircleShape*)self)->getGlobalBounds();
}
void circleshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((CircleShape*)self)->setPosition((float)x, (float)y);
}
void circleshape_setposition_UU2(void* self, void* position) {
    ((CircleShape*)self)->setPosition(*(Vector2f*)position);
}
void circleshape_setrotation_Bw9(void* self, float angle) {
    ((CircleShape*)self)->setRotation((float)angle);
}
void circleshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((CircleShape*)self)->setScale((float)factor_x, (float)factor_y);
}
void circleshape_setscale_UU2(void* self, void* factors) {
    ((CircleShape*)self)->setScale(*(Vector2f*)factors);
}
void circleshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((CircleShape*)self)->setOrigin((float)x, (float)y);
}
void circleshape_setorigin_UU2(void* self, void* origin) {
    ((CircleShape*)self)->setOrigin(*(Vector2f*)origin);
}
void circleshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getPosition();
}
void circleshape_getrotation(void* self, float* result) {
    *(float*)result = ((CircleShape*)self)->getRotation();
}
void circleshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getScale();
}
void circleshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((CircleShape*)self)->getOrigin();
}
void circleshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((CircleShape*)self)->move((float)offset_x, (float)offset_y);
}
void circleshape_move_UU2(void* self, void* offset) {
    ((CircleShape*)self)->move(*(Vector2f*)offset);
}
void circleshape_rotate_Bw9(void* self, float angle) {
    ((CircleShape*)self)->rotate((float)angle);
}
void circleshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((CircleShape*)self)->scale((float)factor_x, (float)factor_y);
}
void circleshape_scale_UU2(void* self, void* factor) {
    ((CircleShape*)self)->scale(*(Vector2f*)factor);
}
void circleshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((CircleShape*)self)->getTransform();
}
void circleshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((CircleShape*)self)->getInverseTransform();
}
void circleshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void circleshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void circleshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(CircleShape*)self, *(RenderStates*)states);
}
void circleshape_initialize_Ii7(void* self, void* copy) {
    new(self) CircleShape(*(CircleShape*)copy);
}
void convexshape_initialize_vgv(void* self, size_t point_count) {
    new(self) ConvexShape((std::size_t)point_count);
}
void convexshape_setpointcount_vgv(void* self, size_t count) {
    ((ConvexShape*)self)->setPointCount((std::size_t)count);
}
void convexshape_getpointcount(void* self, size_t* result) {
    *(std::size_t*)result = ((ConvexShape*)self)->getPointCount();
}
void convexshape_setpoint_vgvUU2(void* self, size_t index, void* point) {
    ((ConvexShape*)self)->setPoint((std::size_t)index, *(Vector2f*)point);
}
void convexshape_getpoint_vgv(void* self, size_t index, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getPoint((std::size_t)index);
}
void convexshape_settexture_MXdGZq(void* self, void* texture, unsigned char reset_rect) {
    ((ConvexShape*)self)->setTexture((Texture*)texture, (bool)reset_rect);
}
void convexshape_settexturerect_2k1(void* self, void* rect) {
    ((ConvexShape*)self)->setTextureRect(*(IntRect*)rect);
}
void convexshape_setfillcolor_QVe(void* self, void* color) {
    ((ConvexShape*)self)->setFillColor(*(Color*)color);
}
void convexshape_setoutlinecolor_QVe(void* self, void* color) {
    ((ConvexShape*)self)->setOutlineColor(*(Color*)color);
}
void convexshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((ConvexShape*)self)->setOutlineThickness((float)thickness);
}
void convexshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((ConvexShape*)self)->getTexture());
}
void convexshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((ConvexShape*)self)->getTextureRect();
}
void convexshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((ConvexShape*)self)->getFillColor();
}
void convexshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((ConvexShape*)self)->getOutlineColor();
}
void convexshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((ConvexShape*)self)->getOutlineThickness();
}
void convexshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((ConvexShape*)self)->getLocalBounds();
}
void convexshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((ConvexShape*)self)->getGlobalBounds();
}
void convexshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((ConvexShape*)self)->setPosition((float)x, (float)y);
}
void convexshape_setposition_UU2(void* self, void* position) {
    ((ConvexShape*)self)->setPosition(*(Vector2f*)position);
}
void convexshape_setrotation_Bw9(void* self, float angle) {
    ((ConvexShape*)self)->setRotation((float)angle);
}
void convexshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((ConvexShape*)self)->setScale((float)factor_x, (float)factor_y);
}
void convexshape_setscale_UU2(void* self, void* factors) {
    ((ConvexShape*)self)->setScale(*(Vector2f*)factors);
}
void convexshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((ConvexShape*)self)->setOrigin((float)x, (float)y);
}
void convexshape_setorigin_UU2(void* self, void* origin) {
    ((ConvexShape*)self)->setOrigin(*(Vector2f*)origin);
}
void convexshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getPosition();
}
void convexshape_getrotation(void* self, float* result) {
    *(float*)result = ((ConvexShape*)self)->getRotation();
}
void convexshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getScale();
}
void convexshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((ConvexShape*)self)->getOrigin();
}
void convexshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((ConvexShape*)self)->move((float)offset_x, (float)offset_y);
}
void convexshape_move_UU2(void* self, void* offset) {
    ((ConvexShape*)self)->move(*(Vector2f*)offset);
}
void convexshape_rotate_Bw9(void* self, float angle) {
    ((ConvexShape*)self)->rotate((float)angle);
}
void convexshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((ConvexShape*)self)->scale((float)factor_x, (float)factor_y);
}
void convexshape_scale_UU2(void* self, void* factor) {
    ((ConvexShape*)self)->scale(*(Vector2f*)factor);
}
void convexshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((ConvexShape*)self)->getTransform();
}
void convexshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((ConvexShape*)self)->getInverseTransform();
}
void convexshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void convexshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void convexshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(ConvexShape*)self, *(RenderStates*)states);
}
void convexshape_initialize_Ydx(void* self, void* copy) {
    new(self) ConvexShape(*(ConvexShape*)copy);
}
void glyph_initialize(void* self) {
    new(self) Glyph();
}
void glyph_setadvance_Bw9(void* self, float advance) {
    ((Glyph*)self)->advance = (float)advance;
}
void glyph_setbounds_5MC(void* self, void* bounds) {
    ((Glyph*)self)->bounds = *(FloatRect*)bounds;
}
void glyph_settexturerect_POq(void* self, void* texture_rect) {
    ((Glyph*)self)->textureRect = *(IntRect*)texture_rect;
}
void glyph_initialize_UlF(void* self, void* copy) {
    new(self) Glyph(*(Glyph*)copy);
}
void image_initialize(void* self) {
    new(self) Image();
}
void image_finalize(void* self) {
    ((Image*)self)->~Image();
}
void image_create_emSemSQVe(void* self, unsigned int width, unsigned int height, void* color) {
    ((Image*)self)->create((unsigned int)width, (unsigned int)height, *(Color*)color);
}
void image_create_emSemS843(void* self, unsigned int width, unsigned int height, uint8_t* pixels) {
    ((Image*)self)->create((unsigned int)width, (unsigned int)height, (Uint8 const*)pixels);
}
void image_loadfromfile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((Image*)self)->loadFromFile(std::string(filename, filename_size));
}
void image_loadfrommemory_5h8vgv(void* self, void* data, size_t size, unsigned char* result) {
    *(bool*)result = ((Image*)self)->loadFromMemory(data, size);
}
void image_loadfromstream_PO0(void* self, void* stream, unsigned char* result) {
    *(bool*)result = ((Image*)self)->loadFromStream(*(InputStream*)stream);
}
void image_savetofile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((Image*)self)->saveToFile(std::string(filename, filename_size));
}
void image_getsize(void* self, void* result) {
    *(Vector2u*)result = ((Image*)self)->getSize();
}
void image_createmaskfromcolor_QVe9yU(void* self, void* color, uint8_t alpha) {
    ((Image*)self)->createMaskFromColor(*(Color*)color, (Uint8)alpha);
}
void image_copy_dptemSemS2k1GZq(void* self, void* source, unsigned int dest_x, unsigned int dest_y, void* source_rect, unsigned char apply_alpha) {
    ((Image*)self)->copy(*(Image*)source, (unsigned int)dest_x, (unsigned int)dest_y, *(IntRect*)source_rect, (bool)apply_alpha);
}
void image_setpixel_emSemSQVe(void* self, unsigned int x, unsigned int y, void* color) {
    ((Image*)self)->setPixel((unsigned int)x, (unsigned int)y, *(Color*)color);
}
void image_getpixel_emSemS(void* self, unsigned int x, unsigned int y, void* result) {
    *(Color*)result = ((Image*)self)->getPixel((unsigned int)x, (unsigned int)y);
}
void image_getpixelsptr(void* self, uint8_t** result) {
    *(Uint8**)result = const_cast<Uint8*>(((Image*)self)->getPixelsPtr());
}
void image_fliphorizontally(void* self) {
    ((Image*)self)->flipHorizontally();
}
void image_flipvertically(void* self) {
    ((Image*)self)->flipVertically();
}
void image_initialize_dpt(void* self, void* copy) {
    new(self) Image(*(Image*)copy);
}
void texture_initialize(void* self) {
    new(self) Texture();
}
void texture_finalize(void* self) {
    ((Texture*)self)->~Texture();
}
void texture_create_emSemS(void* self, unsigned int width, unsigned int height, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->create((unsigned int)width, (unsigned int)height);
}
void texture_loadfromfile_zkC2k1(void* self, size_t filename_size, char* filename, void* area, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->loadFromFile(std::string(filename, filename_size), *(IntRect*)area);
}
void texture_loadfrommemory_5h8vgv2k1(void* self, void* data, size_t size, void* area, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->loadFromMemory(data, size, *(IntRect*)area);
}
void texture_loadfromstream_PO02k1(void* self, void* stream, void* area, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->loadFromStream(*(InputStream*)stream, *(IntRect*)area);
}
void texture_loadfromimage_dpt2k1(void* self, void* image, void* area, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->loadFromImage(*(Image*)image, *(IntRect*)area);
}
void texture_getsize(void* self, void* result) {
    *(Vector2u*)result = ((Texture*)self)->getSize();
}
void texture_copytoimage(void* self, void* result) {
    *(Image*)result = ((Texture*)self)->copyToImage();
}
void texture_update_843(void* self, uint8_t* pixels) {
    ((Texture*)self)->update((Uint8 const*)pixels);
}
void texture_update_843emSemSemSemS(void* self, uint8_t* pixels, unsigned int width, unsigned int height, unsigned int x, unsigned int y) {
    ((Texture*)self)->update((Uint8 const*)pixels, (unsigned int)width, (unsigned int)height, (unsigned int)x, (unsigned int)y);
}
void texture_update_dpt(void* self, void* image) {
    ((Texture*)self)->update(*(Image*)image);
}
void texture_update_dptemSemS(void* self, void* image, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(*(Image*)image, (unsigned int)x, (unsigned int)y);
}
void texture_update_JRh(void* self, void* window) {
    ((Texture*)self)->update(*(Window*)window);
}
void texture_update_JRhemSemS(void* self, void* window, unsigned int x, unsigned int y) {
    ((Texture*)self)->update(*(Window*)window, (unsigned int)x, (unsigned int)y);
}
void texture_setsmooth_GZq(void* self, unsigned char smooth) {
    ((Texture*)self)->setSmooth((bool)smooth);
}
void texture_issmooth(void* self, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->isSmooth();
}
void texture_setrepeated_GZq(void* self, unsigned char repeated) {
    ((Texture*)self)->setRepeated((bool)repeated);
}
void texture_isrepeated(void* self, unsigned char* result) {
    *(bool*)result = ((Texture*)self)->isRepeated();
}
void texture_getnativehandle(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Texture*)self)->getNativeHandle();
}
void texture_bind_MXdK9j(void* texture, int coordinate_type) {
    Texture::bind((Texture*)texture, (Texture::CoordinateType)coordinate_type);
}
void texture_getmaximumsize(unsigned int* result) {
    *(unsigned int*)result = Texture::getMaximumSize();
}
void texture_initialize_DJb(void* self, void* copy) {
    new(self) Texture(*(Texture*)copy);
}
void font_info_initialize(void* self) {
    new(self) Font::Info();
}
void font_info_getfamily(void* self, char** result) {
    static std::string str;
    str = ((Font::Info*)self)->family;
    *result = const_cast<char*>(str.c_str());
}
void font_info_setfamily_Fzm(void* self, size_t family_size, char* family) {
    ((Font::Info*)self)->family = std::string(family, family_size);
}
void font_info_initialize_HPc(void* self, void* copy) {
    new(self) Font::Info(*(Font::Info*)copy);
}
void font_initialize(void* self) {
    new(self) Font();
}
void font_finalize(void* self) {
    ((Font*)self)->~Font();
}
void font_loadfromfile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((Font*)self)->loadFromFile(std::string(filename, filename_size));
}
void font_loadfrommemory_5h8vgv(void* self, void* data, size_t size_in_bytes, unsigned char* result) {
    *(bool*)result = ((Font*)self)->loadFromMemory(data, size_in_bytes);
}
void font_loadfromstream_PO0(void* self, void* stream, unsigned char* result) {
    *(bool*)result = ((Font*)self)->loadFromStream(*(InputStream*)stream);
}
void font_getinfo(void* self, void** result) {
    *(Font::Info**)result = const_cast<Font::Info*>(&((Font*)self)->getInfo());
}
void font_getglyph_saLemSGZq(void* self, uint32_t code_point, unsigned int character_size, unsigned char bold, void* result) {
    *(Glyph*)result = ((Font*)self)->getGlyph((Uint32)code_point, (unsigned int)character_size, (bool)bold);
}
void font_getkerning_saLsaLemS(void* self, uint32_t first, uint32_t second, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getKerning((Uint32)first, (Uint32)second, (unsigned int)character_size);
}
void font_getlinespacing_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getLineSpacing((unsigned int)character_size);
}
void font_getunderlineposition_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getUnderlinePosition((unsigned int)character_size);
}
void font_getunderlinethickness_emS(void* self, unsigned int character_size, float* result) {
    *(float*)result = ((Font*)self)->getUnderlineThickness((unsigned int)character_size);
}
void font_gettexture_emS(void* self, unsigned int character_size, void** result) {
    *(Texture**)result = const_cast<Texture*>(&((Font*)self)->getTexture((unsigned int)character_size));
}
void font_initialize_7CF(void* self, void* copy) {
    new(self) Font(*(Font*)copy);
}
void rectangleshape_initialize_UU2(void* self, void* size) {
    new(self) RectangleShape(*(Vector2f*)size);
}
void rectangleshape_setsize_UU2(void* self, void* size) {
    ((RectangleShape*)self)->setSize(*(Vector2f*)size);
}
void rectangleshape_getsize(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getSize();
}
void rectangleshape_getpointcount(void* self, size_t* result) {
    *(std::size_t*)result = ((RectangleShape*)self)->getPointCount();
}
void rectangleshape_getpoint_vgv(void* self, size_t index, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getPoint((std::size_t)index);
}
void rectangleshape_settexture_MXdGZq(void* self, void* texture, unsigned char reset_rect) {
    ((RectangleShape*)self)->setTexture((Texture*)texture, (bool)reset_rect);
}
void rectangleshape_settexturerect_2k1(void* self, void* rect) {
    ((RectangleShape*)self)->setTextureRect(*(IntRect*)rect);
}
void rectangleshape_setfillcolor_QVe(void* self, void* color) {
    ((RectangleShape*)self)->setFillColor(*(Color*)color);
}
void rectangleshape_setoutlinecolor_QVe(void* self, void* color) {
    ((RectangleShape*)self)->setOutlineColor(*(Color*)color);
}
void rectangleshape_setoutlinethickness_Bw9(void* self, float thickness) {
    ((RectangleShape*)self)->setOutlineThickness((float)thickness);
}
void rectangleshape_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((RectangleShape*)self)->getTexture());
}
void rectangleshape_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((RectangleShape*)self)->getTextureRect();
}
void rectangleshape_getfillcolor(void* self, void* result) {
    *(Color*)result = ((RectangleShape*)self)->getFillColor();
}
void rectangleshape_getoutlinecolor(void* self, void* result) {
    *(Color*)result = ((RectangleShape*)self)->getOutlineColor();
}
void rectangleshape_getoutlinethickness(void* self, float* result) {
    *(float*)result = ((RectangleShape*)self)->getOutlineThickness();
}
void rectangleshape_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((RectangleShape*)self)->getLocalBounds();
}
void rectangleshape_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((RectangleShape*)self)->getGlobalBounds();
}
void rectangleshape_setposition_Bw9Bw9(void* self, float x, float y) {
    ((RectangleShape*)self)->setPosition((float)x, (float)y);
}
void rectangleshape_setposition_UU2(void* self, void* position) {
    ((RectangleShape*)self)->setPosition(*(Vector2f*)position);
}
void rectangleshape_setrotation_Bw9(void* self, float angle) {
    ((RectangleShape*)self)->setRotation((float)angle);
}
void rectangleshape_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((RectangleShape*)self)->setScale((float)factor_x, (float)factor_y);
}
void rectangleshape_setscale_UU2(void* self, void* factors) {
    ((RectangleShape*)self)->setScale(*(Vector2f*)factors);
}
void rectangleshape_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((RectangleShape*)self)->setOrigin((float)x, (float)y);
}
void rectangleshape_setorigin_UU2(void* self, void* origin) {
    ((RectangleShape*)self)->setOrigin(*(Vector2f*)origin);
}
void rectangleshape_getposition(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getPosition();
}
void rectangleshape_getrotation(void* self, float* result) {
    *(float*)result = ((RectangleShape*)self)->getRotation();
}
void rectangleshape_getscale(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getScale();
}
void rectangleshape_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((RectangleShape*)self)->getOrigin();
}
void rectangleshape_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((RectangleShape*)self)->move((float)offset_x, (float)offset_y);
}
void rectangleshape_move_UU2(void* self, void* offset) {
    ((RectangleShape*)self)->move(*(Vector2f*)offset);
}
void rectangleshape_rotate_Bw9(void* self, float angle) {
    ((RectangleShape*)self)->rotate((float)angle);
}
void rectangleshape_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((RectangleShape*)self)->scale((float)factor_x, (float)factor_y);
}
void rectangleshape_scale_UU2(void* self, void* factor) {
    ((RectangleShape*)self)->scale(*(Vector2f*)factor);
}
void rectangleshape_gettransform(void* self, void* result) {
    *(Transform*)result = ((RectangleShape*)self)->getTransform();
}
void rectangleshape_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((RectangleShape*)self)->getInverseTransform();
}
void rectangleshape_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void rectangleshape_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void rectangleshape_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(RectangleShape*)self, *(RenderStates*)states);
}
void rectangleshape_initialize_wlj(void* self, void* copy) {
    new(self) RectangleShape(*(RectangleShape*)copy);
}
void view_initialize(void* self) {
    new(self) View();
}
void view_initialize_WPZ(void* self, void* rectangle) {
    new(self) View(*(FloatRect*)rectangle);
}
void view_initialize_UU2UU2(void* self, void* center, void* size) {
    new(self) View(*(Vector2f*)center, *(Vector2f*)size);
}
void view_setcenter_Bw9Bw9(void* self, float x, float y) {
    ((View*)self)->setCenter((float)x, (float)y);
}
void view_setcenter_UU2(void* self, void* center) {
    ((View*)self)->setCenter(*(Vector2f*)center);
}
void view_setsize_Bw9Bw9(void* self, float width, float height) {
    ((View*)self)->setSize((float)width, (float)height);
}
void view_setsize_UU2(void* self, void* size) {
    ((View*)self)->setSize(*(Vector2f*)size);
}
void view_setrotation_Bw9(void* self, float angle) {
    ((View*)self)->setRotation((float)angle);
}
void view_setviewport_WPZ(void* self, void* viewport) {
    ((View*)self)->setViewport(*(FloatRect*)viewport);
}
void view_reset_WPZ(void* self, void* rectangle) {
    ((View*)self)->reset(*(FloatRect*)rectangle);
}
void view_getcenter(void* self, void* result) {
    *(Vector2f*)result = ((View*)self)->getCenter();
}
void view_getsize(void* self, void* result) {
    *(Vector2f*)result = ((View*)self)->getSize();
}
void view_getrotation(void* self, float* result) {
    *(float*)result = ((View*)self)->getRotation();
}
void view_getviewport(void* self, void* result) {
    *(FloatRect*)result = ((View*)self)->getViewport();
}
void view_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((View*)self)->move((float)offset_x, (float)offset_y);
}
void view_move_UU2(void* self, void* offset) {
    ((View*)self)->move(*(Vector2f*)offset);
}
void view_rotate_Bw9(void* self, float angle) {
    ((View*)self)->rotate((float)angle);
}
void view_zoom_Bw9(void* self, float factor) {
    ((View*)self)->zoom((float)factor);
}
void view_gettransform(void* self, void* result) {
    *(Transform*)result = ((View*)self)->getTransform();
}
void view_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((View*)self)->getInverseTransform();
}
void view_initialize_DDi(void* self, void* copy) {
    new(self) View(*(View*)copy);
}
void rendertarget_clear_QVe(void* self, void* color) {
    ((RenderTarget*)self)->clear(*(Color*)color);
}
void rendertarget_setview_DDi(void* self, void* view) {
    ((RenderTarget*)self)->setView(*(View*)view);
}
void rendertarget_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTarget*)self)->getView());
}
void rendertarget_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTarget*)self)->getDefaultView());
}
void rendertarget_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderTarget*)self)->getViewport(*(View*)view);
}
void rendertarget_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderTarget*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void rendertarget_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderTarget*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void rendertarget_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderTarget*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void rendertarget_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderTarget*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void rendertarget_draw_46svgvu9wmi4(void* self, void* vertices, size_t vertex_count, int type, void* states) {
    ((RenderTarget*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void rendertarget_pushglstates(void* self) {
    ((RenderTarget*)self)->pushGLStates();
}
void rendertarget_popglstates(void* self) {
    ((RenderTarget*)self)->popGLStates();
}
void rendertarget_resetglstates(void* self) {
    ((RenderTarget*)self)->resetGLStates();
}
void rendertexture_initialize(void* self) {
    new(self) RenderTexture();
}
void rendertexture_finalize(void* self) {
    ((RenderTexture*)self)->~RenderTexture();
}
void rendertexture_create_emSemSGZq(void* self, unsigned int width, unsigned int height, unsigned char depth_buffer, unsigned char* result) {
    *(bool*)result = ((RenderTexture*)self)->create((unsigned int)width, (unsigned int)height, (bool)depth_buffer);
}
void rendertexture_setsmooth_GZq(void* self, unsigned char smooth) {
    ((RenderTexture*)self)->setSmooth((bool)smooth);
}
void rendertexture_issmooth(void* self, unsigned char* result) {
    *(bool*)result = ((RenderTexture*)self)->isSmooth();
}
void rendertexture_setrepeated_GZq(void* self, unsigned char repeated) {
    ((RenderTexture*)self)->setRepeated((bool)repeated);
}
void rendertexture_isrepeated(void* self, unsigned char* result) {
    *(bool*)result = ((RenderTexture*)self)->isRepeated();
}
void rendertexture_setactive_GZq(void* self, unsigned char active, unsigned char* result) {
    *(bool*)result = ((RenderTexture*)self)->setActive((bool)active);
}
void rendertexture_display(void* self) {
    ((RenderTexture*)self)->display();
}
void rendertexture_getsize(void* self, void* result) {
    *(Vector2u*)result = ((RenderTexture*)self)->getSize();
}
void rendertexture_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(&((RenderTexture*)self)->getTexture());
}
void rendertexture_clear_QVe(void* self, void* color) {
    ((RenderTexture*)self)->clear(*(Color*)color);
}
void rendertexture_setview_DDi(void* self, void* view) {
    ((RenderTexture*)self)->setView(*(View*)view);
}
void rendertexture_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTexture*)self)->getView());
}
void rendertexture_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderTexture*)self)->getDefaultView());
}
void rendertexture_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderTexture*)self)->getViewport(*(View*)view);
}
void rendertexture_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderTexture*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void rendertexture_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderTexture*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void rendertexture_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderTexture*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void rendertexture_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderTexture*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void rendertexture_draw_46svgvu9wmi4(void* self, void* vertices, size_t vertex_count, int type, void* states) {
    ((RenderTexture*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void rendertexture_pushglstates(void* self) {
    ((RenderTexture*)self)->pushGLStates();
}
void rendertexture_popglstates(void* self) {
    ((RenderTexture*)self)->popGLStates();
}
void rendertexture_resetglstates(void* self) {
    ((RenderTexture*)self)->resetGLStates();
}
void renderwindow_initialize(void* self) {
    new(self) RenderWindow();
}
void renderwindow_initialize_wg0bQssaLFw4(void* self, void* mode, size_t title_size, uint32_t* title, uint32_t style, void* settings) {
    new(self) RenderWindow(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), (Uint32)style, *(ContextSettings*)settings);
}
void renderwindow_initialize_rLQFw4(void* self, WindowHandle handle, void* settings) {
    new(self) RenderWindow((WindowHandle)handle, *(ContextSettings*)settings);
}
void renderwindow_finalize(void* self) {
    ((RenderWindow*)self)->~RenderWindow();
}
void renderwindow_getsize(void* self, void* result) {
    *(Vector2u*)result = ((RenderWindow*)self)->getSize();
}
void renderwindow_capture(void* self, void* result) {
    *(Image*)result = ((RenderWindow*)self)->capture();
}
void renderwindow_create_wg0bQssaLFw4(void* self, void* mode, size_t title_size, uint32_t* title, uint32_t style, void* settings) {
    ((RenderWindow*)self)->create(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), (Uint32)style, *(ContextSettings*)settings);
}
void renderwindow_create_rLQFw4(void* self, WindowHandle handle, void* settings) {
    ((RenderWindow*)self)->create((WindowHandle)handle, *(ContextSettings*)settings);
}
void renderwindow_close(void* self) {
    ((RenderWindow*)self)->close();
}
void renderwindow_isopen(void* self, unsigned char* result) {
    *(bool*)result = ((RenderWindow*)self)->isOpen();
}
void renderwindow_getsettings(void* self, void* result) {
    *(ContextSettings*)result = ((RenderWindow*)self)->getSettings();
}
void renderwindow_pollevent_YJW(void* self, void* event, unsigned char* result) {
    *(bool*)result = ((RenderWindow*)self)->pollEvent(*(Event*)event);
}
void renderwindow_waitevent_YJW(void* self, void* event, unsigned char* result) {
    *(bool*)result = ((RenderWindow*)self)->waitEvent(*(Event*)event);
}
void renderwindow_getposition(void* self, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->getPosition();
}
void renderwindow_setposition_ufV(void* self, void* position) {
    ((RenderWindow*)self)->setPosition(*(Vector2i*)position);
}
void renderwindow_setsize_DXO(void* self, void* size) {
    ((RenderWindow*)self)->setSize(*(Vector2u*)size);
}
void renderwindow_settitle_bQs(void* self, size_t title_size, uint32_t* title) {
    ((RenderWindow*)self)->setTitle(String::fromUtf32(title, title+title_size));
}
void renderwindow_seticon_emSemS843(void* self, unsigned int width, unsigned int height, uint8_t* pixels) {
    ((RenderWindow*)self)->setIcon((unsigned int)width, (unsigned int)height, (Uint8 const*)pixels);
}
void renderwindow_setvisible_GZq(void* self, unsigned char visible) {
    ((RenderWindow*)self)->setVisible((bool)visible);
}
void renderwindow_setverticalsyncenabled_GZq(void* self, unsigned char enabled) {
    ((RenderWindow*)self)->setVerticalSyncEnabled((bool)enabled);
}
void renderwindow_setmousecursorvisible_GZq(void* self, unsigned char visible) {
    ((RenderWindow*)self)->setMouseCursorVisible((bool)visible);
}
void renderwindow_setkeyrepeatenabled_GZq(void* self, unsigned char enabled) {
    ((RenderWindow*)self)->setKeyRepeatEnabled((bool)enabled);
}
void renderwindow_setframeratelimit_emS(void* self, unsigned int limit) {
    ((RenderWindow*)self)->setFramerateLimit((unsigned int)limit);
}
void renderwindow_setjoystickthreshold_Bw9(void* self, float threshold) {
    ((RenderWindow*)self)->setJoystickThreshold((float)threshold);
}
void renderwindow_setactive_GZq(void* self, unsigned char active, unsigned char* result) {
    *(bool*)result = ((RenderWindow*)self)->setActive((bool)active);
}
void renderwindow_requestfocus(void* self) {
    ((RenderWindow*)self)->requestFocus();
}
void renderwindow_hasfocus(void* self, unsigned char* result) {
    *(bool*)result = ((RenderWindow*)self)->hasFocus();
}
void renderwindow_display(void* self) {
    ((RenderWindow*)self)->display();
}
void renderwindow_getsystemhandle(void* self, WindowHandle* result) {
    *(WindowHandle*)result = ((RenderWindow*)self)->getSystemHandle();
}
void renderwindow_clear_QVe(void* self, void* color) {
    ((RenderWindow*)self)->clear(*(Color*)color);
}
void renderwindow_setview_DDi(void* self, void* view) {
    ((RenderWindow*)self)->setView(*(View*)view);
}
void renderwindow_getview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderWindow*)self)->getView());
}
void renderwindow_getdefaultview(void* self, void** result) {
    *(View**)result = const_cast<View*>(&((RenderWindow*)self)->getDefaultView());
}
void renderwindow_getviewport_DDi(void* self, void* view, void* result) {
    *(IntRect*)result = ((RenderWindow*)self)->getViewport(*(View*)view);
}
void renderwindow_mappixeltocoords_ufV(void* self, void* point, void* result) {
    *(Vector2f*)result = ((RenderWindow*)self)->mapPixelToCoords(*(Vector2i*)point);
}
void renderwindow_mappixeltocoords_ufVDDi(void* self, void* point, void* view, void* result) {
    *(Vector2f*)result = ((RenderWindow*)self)->mapPixelToCoords(*(Vector2i*)point, *(View*)view);
}
void renderwindow_mapcoordstopixel_UU2(void* self, void* point, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->mapCoordsToPixel(*(Vector2f*)point);
}
void renderwindow_mapcoordstopixel_UU2DDi(void* self, void* point, void* view, void* result) {
    *(Vector2i*)result = ((RenderWindow*)self)->mapCoordsToPixel(*(Vector2f*)point, *(View*)view);
}
void renderwindow_draw_46svgvu9wmi4(void* self, void* vertices, size_t vertex_count, int type, void* states) {
    ((RenderWindow*)self)->draw((Vertex*)vertices, vertex_count, (PrimitiveType)type, *(RenderStates*)states);
}
void renderwindow_pushglstates(void* self) {
    ((RenderWindow*)self)->pushGLStates();
}
void renderwindow_popglstates(void* self) {
    ((RenderWindow*)self)->popGLStates();
}
void renderwindow_resetglstates(void* self) {
    ((RenderWindow*)self)->resetGLStates();
}
void shader_initialize(void* self) {
    new(self) Shader();
}
void shader_finalize(void* self) {
    ((Shader*)self)->~Shader();
}
void shader_loadfromfile_zkCqL0(void* self, size_t filename_size, char* filename, int type, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromFile(std::string(filename, filename_size), (Shader::Type)type);
}
void shader_loadfromfile_zkCzkC(void* self, size_t vertex_shader_filename_size, char* vertex_shader_filename, size_t fragment_shader_filename_size, char* fragment_shader_filename, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromFile(std::string(vertex_shader_filename, vertex_shader_filename_size), std::string(fragment_shader_filename, fragment_shader_filename_size));
}
void shader_loadfrommemory_zkCqL0(void* self, size_t shader_size, char* shader, int type, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromMemory(std::string(shader, shader_size), (Shader::Type)type);
}
void shader_loadfrommemory_zkCzkC(void* self, size_t vertex_shader_size, char* vertex_shader, size_t fragment_shader_size, char* fragment_shader, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromMemory(std::string(vertex_shader, vertex_shader_size), std::string(fragment_shader, fragment_shader_size));
}
void shader_loadfromstream_PO0qL0(void* self, void* stream, int type, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromStream(*(InputStream*)stream, (Shader::Type)type);
}
void shader_loadfromstream_PO0PO0(void* self, void* vertex_shader_stream, void* fragment_shader_stream, unsigned char* result) {
    *(bool*)result = ((Shader*)self)->loadFromStream(*(InputStream*)vertex_shader_stream, *(InputStream*)fragment_shader_stream);
}
void shader_setparameter_zkCBw9(void* self, size_t name_size, char* name, float x) {
    ((Shader*)self)->setParameter(std::string(name, name_size), (float)x);
}
void shader_setparameter_zkCBw9Bw9(void* self, size_t name_size, char* name, float x, float y) {
    ((Shader*)self)->setParameter(std::string(name, name_size), (float)x, (float)y);
}
void shader_setparameter_zkCBw9Bw9Bw9(void* self, size_t name_size, char* name, float x, float y, float z) {
    ((Shader*)self)->setParameter(std::string(name, name_size), (float)x, (float)y, (float)z);
}
void shader_setparameter_zkCBw9Bw9Bw9Bw9(void* self, size_t name_size, char* name, float x, float y, float z, float w) {
    ((Shader*)self)->setParameter(std::string(name, name_size), (float)x, (float)y, (float)z, (float)w);
}
void shader_setparameter_zkCUU2(void* self, size_t name_size, char* name, void* vector) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Vector2f*)vector);
}
void shader_setparameter_zkCNzM(void* self, size_t name_size, char* name, void* vector) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Vector3f*)vector);
}
void shader_setparameter_zkCQVe(void* self, size_t name_size, char* name, void* color) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Color*)color);
}
void shader_setparameter_zkCFPe(void* self, size_t name_size, char* name, void* transform) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Transform*)transform);
}
void shader_setparameter_zkCDJb(void* self, size_t name_size, char* name, void* texture) {
    ((Shader*)self)->setParameter(std::string(name, name_size), *(Texture*)texture);
}
void shader_setparameter_zkCLcV(void* self, size_t name_size, char* name) {
    ((Shader*)self)->setParameter(std::string(name, name_size), Shader::CurrentTexture);
}
void shader_getnativehandle(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Shader*)self)->getNativeHandle();
}
void shader_bind_8P6(void* shader) {
    Shader::bind((Shader*)shader);
}
void shader_isavailable(unsigned char* result) {
    *(bool*)result = Shader::isAvailable();
}
void sprite_initialize(void* self) {
    new(self) Sprite();
}
void sprite_initialize_DJb(void* self, void* texture) {
    new(self) Sprite(*(Texture*)texture);
}
void sprite_initialize_DJb2k1(void* self, void* texture, void* rectangle) {
    new(self) Sprite(*(Texture*)texture, *(IntRect*)rectangle);
}
void sprite_settexture_DJbGZq(void* self, void* texture, unsigned char reset_rect) {
    ((Sprite*)self)->setTexture(*(Texture*)texture, (bool)reset_rect);
}
void sprite_settexturerect_2k1(void* self, void* rectangle) {
    ((Sprite*)self)->setTextureRect(*(IntRect*)rectangle);
}
void sprite_setcolor_QVe(void* self, void* color) {
    ((Sprite*)self)->setColor(*(Color*)color);
}
void sprite_gettexture(void* self, void** result) {
    *(Texture**)result = const_cast<Texture*>(((Sprite*)self)->getTexture());
}
void sprite_gettexturerect(void* self, void* result) {
    *(IntRect*)result = ((Sprite*)self)->getTextureRect();
}
void sprite_getcolor(void* self, void* result) {
    *(Color*)result = ((Sprite*)self)->getColor();
}
void sprite_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Sprite*)self)->getLocalBounds();
}
void sprite_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Sprite*)self)->getGlobalBounds();
}
void sprite_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Sprite*)self)->setPosition((float)x, (float)y);
}
void sprite_setposition_UU2(void* self, void* position) {
    ((Sprite*)self)->setPosition(*(Vector2f*)position);
}
void sprite_setrotation_Bw9(void* self, float angle) {
    ((Sprite*)self)->setRotation((float)angle);
}
void sprite_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Sprite*)self)->setScale((float)factor_x, (float)factor_y);
}
void sprite_setscale_UU2(void* self, void* factors) {
    ((Sprite*)self)->setScale(*(Vector2f*)factors);
}
void sprite_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Sprite*)self)->setOrigin((float)x, (float)y);
}
void sprite_setorigin_UU2(void* self, void* origin) {
    ((Sprite*)self)->setOrigin(*(Vector2f*)origin);
}
void sprite_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getPosition();
}
void sprite_getrotation(void* self, float* result) {
    *(float*)result = ((Sprite*)self)->getRotation();
}
void sprite_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getScale();
}
void sprite_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Sprite*)self)->getOrigin();
}
void sprite_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Sprite*)self)->move((float)offset_x, (float)offset_y);
}
void sprite_move_UU2(void* self, void* offset) {
    ((Sprite*)self)->move(*(Vector2f*)offset);
}
void sprite_rotate_Bw9(void* self, float angle) {
    ((Sprite*)self)->rotate((float)angle);
}
void sprite_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Sprite*)self)->scale((float)factor_x, (float)factor_y);
}
void sprite_scale_UU2(void* self, void* factor) {
    ((Sprite*)self)->scale(*(Vector2f*)factor);
}
void sprite_gettransform(void* self, void* result) {
    *(Transform*)result = ((Sprite*)self)->getTransform();
}
void sprite_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Sprite*)self)->getInverseTransform();
}
void sprite_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sprite_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sprite_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(Sprite*)self, *(RenderStates*)states);
}
void sprite_initialize_8xu(void* self, void* copy) {
    new(self) Sprite(*(Sprite*)copy);
}
void text_initialize(void* self) {
    new(self) Text();
}
void text_initialize_bQs7CFemS(void* self, size_t string_size, uint32_t* string, void* font, unsigned int character_size) {
    new(self) Text(String::fromUtf32(string, string+string_size), *(Font*)font, (unsigned int)character_size);
}
void text_setstring_bQs(void* self, size_t string_size, uint32_t* string) {
    ((Text*)self)->setString(String::fromUtf32(string, string+string_size));
}
void text_setfont_7CF(void* self, void* font) {
    ((Text*)self)->setFont(*(Font*)font);
}
void text_setcharactersize_emS(void* self, unsigned int size) {
    ((Text*)self)->setCharacterSize((unsigned int)size);
}
void text_setstyle_saL(void* self, uint32_t style) {
    ((Text*)self)->setStyle((Uint32)style);
}
void text_setcolor_QVe(void* self, void* color) {
    ((Text*)self)->setColor(*(Color*)color);
}
void text_getstring(void* self, uint32_t** result) {
    static String str;
    str = ((Text*)self)->getString();
    *result = const_cast<uint32_t*>(str.getData());
}
void text_getfont(void* self, void** result) {
    *(Font**)result = const_cast<Font*>(((Text*)self)->getFont());
}
void text_getcharactersize(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Text*)self)->getCharacterSize();
}
void text_getstyle(void* self, uint32_t* result) {
    *(Uint32*)result = ((Text*)self)->getStyle();
}
void text_getcolor(void* self, void* result) {
    *(Color*)result = ((Text*)self)->getColor();
}
void text_findcharacterpos_vgv(void* self, size_t index, void* result) {
    *(Vector2f*)result = ((Text*)self)->findCharacterPos((std::size_t)index);
}
void text_getlocalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Text*)self)->getLocalBounds();
}
void text_getglobalbounds(void* self, void* result) {
    *(FloatRect*)result = ((Text*)self)->getGlobalBounds();
}
void text_setposition_Bw9Bw9(void* self, float x, float y) {
    ((Text*)self)->setPosition((float)x, (float)y);
}
void text_setposition_UU2(void* self, void* position) {
    ((Text*)self)->setPosition(*(Vector2f*)position);
}
void text_setrotation_Bw9(void* self, float angle) {
    ((Text*)self)->setRotation((float)angle);
}
void text_setscale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Text*)self)->setScale((float)factor_x, (float)factor_y);
}
void text_setscale_UU2(void* self, void* factors) {
    ((Text*)self)->setScale(*(Vector2f*)factors);
}
void text_setorigin_Bw9Bw9(void* self, float x, float y) {
    ((Text*)self)->setOrigin((float)x, (float)y);
}
void text_setorigin_UU2(void* self, void* origin) {
    ((Text*)self)->setOrigin(*(Vector2f*)origin);
}
void text_getposition(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getPosition();
}
void text_getrotation(void* self, float* result) {
    *(float*)result = ((Text*)self)->getRotation();
}
void text_getscale(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getScale();
}
void text_getorigin(void* self, void* result) {
    *(Vector2f*)result = ((Text*)self)->getOrigin();
}
void text_move_Bw9Bw9(void* self, float offset_x, float offset_y) {
    ((Text*)self)->move((float)offset_x, (float)offset_y);
}
void text_move_UU2(void* self, void* offset) {
    ((Text*)self)->move(*(Vector2f*)offset);
}
void text_rotate_Bw9(void* self, float angle) {
    ((Text*)self)->rotate((float)angle);
}
void text_scale_Bw9Bw9(void* self, float factor_x, float factor_y) {
    ((Text*)self)->scale((float)factor_x, (float)factor_y);
}
void text_scale_UU2(void* self, void* factor) {
    ((Text*)self)->scale(*(Vector2f*)factor);
}
void text_gettransform(void* self, void* result) {
    *(Transform*)result = ((Text*)self)->getTransform();
}
void text_getinversetransform(void* self, void* result) {
    *(Transform*)result = ((Text*)self)->getInverseTransform();
}
void text_draw_kb9RoT(void* self, void* target, void* states) {
    ((RenderTexture*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void text_draw_fqURoT(void* self, void* target, void* states) {
    ((RenderWindow*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void text_draw_Xk1RoT(void* self, void* target, void* states) {
    ((RenderTarget*)target)->draw(*(Text*)self, *(RenderStates*)states);
}
void text_initialize_clM(void* self, void* copy) {
    new(self) Text(*(Text*)copy);
}
void sfml_graphics_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
