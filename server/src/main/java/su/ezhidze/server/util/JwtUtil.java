package su.ezhidze.server.util;

import io.jsonwebtoken.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import su.ezhidze.server.entity.User;
import su.ezhidze.server.exception.AuthenticationFailException;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Component
public class JwtUtil {
    private final String secretKey = "49A7D01B197E26CF7EDF3E4A555B1E8760ADC927EA6776D491FFE9A020E6C1A4";

    private final JwtParser jwtParser;

    public JwtUtil() {
        this.jwtParser = Jwts.parser().setSigningKey(secretKey);
    }

    public String createToken(final User user) {
        Claims claims = Jwts.claims().setSubject(user.getEmail());
        claims.put("firstName", user.getFirstName());
        claims.put("lastName", user.getLastName());
        Date tokenCreateTime = new Date();
        Date tokenValidity = new Date(tokenCreateTime.getTime() + TimeUnit.MINUTES.toMillis(60 * 60 * 1000));
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(tokenValidity)
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    private Claims parseJwtClaims(String token) {
        return jwtParser.parseClaimsJws(token).getBody();
    }

    public Claims resolveClaims(HttpServletRequest req) {
        try {
            return parseJwtClaims(resolveToken(req));
        } catch (IllegalArgumentException e) {
            throw new AuthenticationFailException("ClaimsJws string is null or empty or only whitespace");
        } catch (ExpiredJwtException e) {
            req.setAttribute("expired", e.getMessage());
            throw e;
        } catch (Exception e) {
            req.setAttribute("invalid", e.getMessage());
            throw e;
        }
    }

    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        String tokenPrefix = "Bearer ";
        if (bearerToken != null && bearerToken.startsWith(tokenPrefix)) {
            return bearerToken.substring(tokenPrefix.length());
        } else if (bearerToken == null) {
            return null;
        } else throw new AuthenticationFailException("Token not found");
    }

    public boolean validateClaims(Claims claims) throws AuthenticationException {
        try {
            return claims.getExpiration().after(new Date());
        } catch (Exception e) {
            throw e;
        }
    }

    public String getEmail(Claims claims) {
        return claims.getSubject();
    }

    private List<String> getRoles(Claims claims) {
        return (List<String>) claims.get("roles");
    }
}
