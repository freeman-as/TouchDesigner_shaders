uniform vec4 uDiffuseColor;
uniform vec4 uAmbientColor;
uniform vec3 uSpecularColor;
uniform float uShininess;
uniform float uShadowStrength;
uniform vec3 uShadowColor;

// custom uniform
uniform sampler2D dispTex;
uniform float dispScale;
uniform float time;

out Vertex
{
	vec4 color;
	vec3 worldSpacePos;
	vec3 worldSpaceNorm;
	flat int cameraIndex;
} oVert;

void main()
{
	// UV座標の取得
	vec2 uv = uv[0].st;
	// ディスプレースメントマップの取得
	vec3 disp = texture(dispTex, uv).rgb;
	// 各頂点座標を法線方向にディスプレースメントマップのノイズ値に応じた値分移動
	// 掛け合わせるdispScaleで移動量をスケーリング
	vec3 pos = P + disp * N * dispScale;
	vec4 worldSpacePos = TDDeform(pos);
	gl_Position = TDWorldToProj(worldSpacePos);

	// This is here to ensure we only execute lighting etc. code
	// when we need it. If picking is active we don't need this, so
	// this entire block of code will be ommited from the compile.
	// The TD_PICKING_ACTIVE define will be set automatically when
	// picking is active.
#ifndef TD_PICKING_ACTIVE

	int cameraIndex = TDCameraIndex();
	oVert.cameraIndex = cameraIndex;
	oVert.worldSpacePos.xyz = worldSpacePos.xyz;
	oVert.color = TDInstanceColor(Cd);
	vec3 worldSpaceNorm = normalize(TDDeformNorm(N));
	oVert.worldSpaceNorm.xyz = worldSpaceNorm;

#else // TD_PICKING_ACTIVE

	// This will automatically write out the nessessary values
	// for this shader to work with picking.
	// See the documentation if you want to write custom values for picking.
	TDWritePickingValues();

#endif // TD_PICKING_ACTIVE
}
